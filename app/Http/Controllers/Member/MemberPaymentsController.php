<?php

namespace App\Http\Controllers\Member;

use App\Currency;
use App\Helper\Reply;
use App\Http\Requests\Payments\StorePayment;
use App\Http\Requests\Payments\UpdatePayments;
use App\Invoice;
use App\ModuleSetting;
use App\Payment;
use App\Project;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\Facades\DataTables;

class MemberPaymentsController extends MemberBaseController
{
    public function __construct() {
        parent::__construct();
        $this->pageTitle = __('app.menu.payments');
        $this->pageIcon = 'fa fa-money';
        $this->middleware(function ($request, $next) {
            if(!in_array('payments',$this->user->modules)){
                abort(403);
            }
            return $next($request);
        });

    }

    public function index() {
        if(!$this->user->can('view_payments')){
            abort(403);
        }
        $this->projects = Project::all();
        return view('member.payments.index', $this->data);
    }

    public function data(Request $request) {
        $payments = Payment::leftJoin('projects', 'projects.id', '=', 'payments.project_id')
            ->join('currencies', 'currencies.id', '=', 'payments.currency_id')
            ->select('payments.id', 'payments.project_id', 'payments.amount','projects.project_name', 'currencies.currency_symbol', 'currencies.currency_code', 'payments.status', 'payments.paid_on');

        if($request->startDate !== null && $request->startDate != 'null' && $request->startDate != ''){
            $payments = $payments->where(DB::raw('DATE(payments.`paid_on`)'), '>=', $request->startDate);
        }

        if($request->endDate !== null && $request->endDate != 'null' && $request->endDate != ''){
            $payments = $payments->where(DB::raw('DATE(payments.`paid_on`)'), '<=', $request->endDate);
        }

        if($request->status != 'all' && !is_null($request->status)){
            $payments = $payments->where('payments.status', '=', $request->status);
        }

        if($request->project != 'all' && !is_null($request->project)){
            $payments = $payments->where('payments.project_id', '=', $request->project);
        }

        $payments = $payments->orderBy('payments.id', 'desc')->get();

        return DataTables::of($payments)
            ->addColumn('action', function ($row) {
                $action = '';
                if($this->user->can('edit_payments')){
                    $action.= '<a href="' . route("member.payments.edit", $row->id) . '" data-toggle="tooltip" data-original-title="Edit" class="btn btn-info btn-circle"><i class="fa fa-pencil"></i></a>';
                }
                if($this->user->can('delete_payments')) {
                    $action .= '&nbsp;&nbsp;<a href="javascript:;" data-toggle="tooltip" data-original-title="Delete" data-payment-id="' . $row->id . '" class="btn btn-danger btn-circle sa-params"><i class="fa fa-times"></i></a>';
                }
                return $action;
            })

            ->editColumn('project_id', function($row) {
                if($row->project_id != null){
                    return ucfirst($row->project_name);
                }
                else{
                    return '--';
                }

            })
            ->editColumn('status', function ($row) {
                if($row->status == 'pending'){
                    return '<label class="label label-warning">'.strtoupper($row->status).'</label>';
                }else{
                    return '<label class="label label-success">'.strtoupper($row->status).'</label>';
                }
            })
            ->editColumn('amount', function ($row) {
                return $row->currency_symbol . number_format((float)$row->amount, 2, '.', ''). ' ('.$row->currency_code.')';
            })
            ->editColumn(
                'paid_on',
                function ($row) {
                    if(!is_null($row->paid_on)){
                        return $row->paid_on->format($this->global->date_format .' '. $this->global->time_format);
                    }
                }
            )
            ->rawColumns(['action', 'status'])
            ->removeColumn('invoice_id')
            ->removeColumn('currency_symbol')
            ->removeColumn('currency_code')
            ->removeColumn('project_name')
            ->make(true);
    }

    public function create(){
        if(!$this->user->can('add_payments')){
            abort(403);
        }
        $this->projects = Project::all();
        $this->currencies = Currency::all();
        return view('member.payments.create', $this->data);
    }

    public function store(StorePayment $request){
        $payment = new Payment();
        if($request->project_id != ''){
            $payment->project_id = $request->project_id;
            $payment->currency_id = $request->currency_id;
        }

        elseif($request->has('invoice_id') ){
            $invoice = Invoice::findOrFail($request->invoice_id);
            $payment->project_id = $invoice->project_id;
            $payment->invoice_id = $invoice->id;
            $payment->currency_id = $invoice->currency->id;
            $paidAmount = $invoice->getPaidAmount();
        }
        else{
            $currency = Currency::first();
            $payment->currency_id = $currency->id;
        }

        $payment->amount = round($request->amount,2);
        $payment->gateway = $request->gateway;
        $payment->transaction_id = $request->transaction_id;
        $payment->paid_on = Carbon::createFromFormat('d/m/Y H:i', $request->paid_on)->format('Y-m-d H:i:s');
        $payment->remarks = $request->remarks;
        $payment->save();

        if($request->has('invoice_id') ){

            if(($paidAmount+$request->amount) >= $invoice->total){
                $invoice->status = 'paid';
            }
            else{
                $invoice->status = 'partial';
            }
            $invoice->save();

        }


        return Reply::redirect(route('member.payments.index'), __('messages.paymentSuccess'));
    }

    public function destroy($id) {
        Payment::destroy($id);
        return Reply::success(__('messages.paymentDeleted'));
    }

    public function edit($id){
        if(!$this->user->can('edit_payments')){
            abort(403);
        }
        $this->projects = Project::all();
        $this->currencies = Currency::all();
        $this->payment = Payment::findOrFail($id);
        return view('member.payments.edit', $this->data);
    }

    public function update(UpdatePayments $request, $id){
        $payment = Payment::findOrFail($id);
        if($request->project_id != ''){
            $payment->project_id = $request->project_id;
        }
        $payment->currency_id = $request->currency_id;
        $payment->amount = round($request->amount, 2);
        $payment->gateway = $request->gateway;
        $payment->transaction_id = $request->transaction_id;
        $payment->paid_on = Carbon::createFromFormat('d/m/Y H:i', $request->paid_on)->format('Y-m-d H:i:s');
        $payment->status = 'complete';
        $payment->remarks = $request->remarks;
        $payment->save();

        return Reply::redirect(route('member.payments.index'), __('messages.paymentSuccess'));
    }

    public function payInvoice($invoiceId){
        $this->invoice = Invoice::findOrFail($invoiceId);
        $this->paidAmount = $this->invoice->getPaidAmount();

        if($this->invoice->status == 'paid'){
            return "Invoice already paid";
        }

        return view('member.payments.pay-invoice', $this->data);
    }

}
