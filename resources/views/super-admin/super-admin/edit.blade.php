@extends('layouts.super-admin')

@section('page-title')
    <div class="row bg-title">
        <!-- .page title -->
        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
            <h4 class="page-title"><i class="{{ $pageIcon }}"></i> {{ $pageTitle }}</h4>
        </div>
        <!-- /.page title -->
        <!-- .breadcrumb -->
        <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12">
            <ol class="breadcrumb">
                <li><a href="{{ route('super-admin.dashboard') }}">@lang('app.menu.home')</a></li>
                <li><a href="{{ route('super-admin.packages.index') }}">{{ $pageTitle }}</a></li>
                <li class="active">@lang('app.edit')</li>
            </ol>
        </div>
        <!-- /.breadcrumb -->
    </div>
@endsection

@push('head-script')
<link rel="stylesheet" href="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css') }}">
@endpush

@section('content')

    <div class="row">
        <div class="col-md-12">

            <div class="panel panel-inverse">
                <div class="panel-heading"> @lang('app.update') @lang('app.superAdmin')</div>
                <div class="panel-wrapper collapse in" aria-expanded="true">
                    <div class="panel-body">
                        {!! Form::open(['id'=>'updateClient','class'=>'ajax-form','method'=>'PUT']) !!}
                        <div class="form-body">
                            <div class="row">
                                <div class="col-md-12 ">
                                    <div class="form-group">
                                        <label>@lang('app.name')</label>
                                        <input type="text" name="name" id="name"
                                               class="form-control" value="{{ $userDetail->name }}">
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>@lang('app.email')</label>
                                        <input type="email" name="email" id="email"
                                               class="form-control" value="{{ $userDetail->email }}">
                                    </div>
                                </div>
                                <!--/span-->
                            </div>
                            <div class="row">

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>@lang('app.password')</label>
                                        <input type="password" name="password" id="password"
                                               class="form-control">
                                        <span class="help-block"> @lang('modules.profile.passwordNote')</span>
                                    </div>
                                </div>
                                <!--/span-->

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>@lang('app.mobileNumber')</label>
                                        <input type="tel" name="mobile" id="mobile" class="form-control"
                                               value="{{ $userDetail->mobile }}">
                                    </div>
                                </div>
                                <!--/span-->

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>@lang('modules.employees.gender')</label>
                                        <select name="gender" id="gender" class="form-control">
                                            <option @if($userDetail->gender == 'male') selected @endif value="male">@lang('app.male')</option>
                                            <option @if($userDetail->gender == 'female') selected @endif value="female">@lang('app.female')</option>
                                            <option @if($userDetail->gender == 'others') selected @endif value="others">@lang('app.others')</option>
                                        </select>
                                    </div>
                                </div>
                                <!--/span-->

                                <!--/span-->
                                @if($user->id != $userDetail->id)
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>@lang('app.status')</label>
                                        <select name="status" id="status" class="form-control">
                                            <option @if($userDetail->status == 'active') selected @endif value="active">@lang('app.active')</option>
                                            <option @if($userDetail->status == 'deactive') selected @endif value="deactive">@lang('app.deactive')</option>
                                        </select>
                                    </div>
                                </div>
                                @endif
                                <!--/span-->
                            </div>
                            <!--/row-->

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label">@lang('app.address')</label>
                                        <textarea name="address" id="address" rows="5"
                                                  class="form-control">@if(!empty($employeeDetail)){{ $employeeDetail->address }}@endif</textarea>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <label>@lang('modules.profile.profilePicture')</label>

                                    <div class="form-group">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="fileinput-new thumbnail"
                                                 style="width: 200px; height: 150px;">
                                                @if(is_null($userDetail->image))
                                                    <img src="https://placeholdit.imgix.net/~text?txtsize=25&txt=@lang('modules.profile.uploadPicture')&w=200&h=150"
                                                         alt=""/>
                                                @else
                                                    <img src="{{ asset('user-uploads/avatar/'.$userDetail->image) }}"
                                                         alt=""/>
                                                @endif
                                            </div>
                                            <div class="fileinput-preview fileinput-exists thumbnail"
                                                 style="max-width: 200px; max-height: 150px;"></div>
                                            <div>
                                <span class="btn btn-info btn-file">
                                    <span class="fileinput-new"> @lang('app.selectImage') </span>
                                    <span class="fileinput-exists"> @lang('app.change') </span>
                                    <input type="file" name="image" id="image"> </span>
                                                <a href="javascript:;"
                                                   class="btn btn-danger fileinput-exists"
                                                   data-dismiss="fileinput"> @lang('app.remove') </a>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <!--/span-->


                        </div>
                        <div class="form-actions">
                            <button type="submit" id="save-form" class="btn btn-success"> <i class="fa fa-check"></i> @lang('app.update')</button>
                            <a href="{{ route('super-admin.packages.index') }}" class="btn btn-default">@lang('app.back')</a>
                        </div>
                        {!! Form::close() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>    <!-- .row -->

@endsection

@push('footer-script')
<script src="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.js') }}"></script>
<script>
    $(".date-picker").datepicker({
        todayHighlight: true,
        autoclose: true
    });
    
    $('#save-form').click(function () {
        $.easyAjax({
            url: '{{route('super-admin.super-admin.update', [$userDetail->id])}}',
            container: '#updateClient',
            type: "POST",
            redirect: true,
            file: true
        })
    });
</script>
@endpush