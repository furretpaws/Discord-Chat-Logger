// Generated by Haxe 4.3.1
#include <hxcpp.h>

#ifndef INCLUDED_haxe_Int64Helper
#include <haxe/Int64Helper.h>
#endif
#ifndef INCLUDED_haxe__Int64_Int64_Impl_
#include <haxe/_Int64/Int64_Impl_.h>
#endif

HX_LOCAL_STACK_FRAME(_hx_pos_3debe8910def42a5_193_fromFloat,"haxe._Int64.Int64_Impl_","fromFloat",0xa3d45c39,"haxe._Int64.Int64_Impl_.fromFloat","C:\\HaxeToolkit\\haxe\\std/cpp/_std/haxe/Int64.hx",193,0x97dcebb4)
namespace haxe{
namespace _Int64{

void Int64_Impl__obj::__construct() { }

Dynamic Int64_Impl__obj::__CreateEmpty() { return new Int64_Impl__obj; }

void *Int64_Impl__obj::_hx_vtable = 0;

Dynamic Int64_Impl__obj::__Create(::hx::DynamicArray inArgs)
{
	::hx::ObjectPtr< Int64_Impl__obj > _hx_result = new Int64_Impl__obj();
	_hx_result->__construct();
	return _hx_result;
}

bool Int64_Impl__obj::_hx_isInstanceOf(int inClassId) {
	return inClassId==(int)0x00000001 || inClassId==(int)0x66145239;
}

::cpp::Int64 Int64_Impl__obj::fromFloat(Float f){
            	HX_STACKFRAME(&_hx_pos_3debe8910def42a5_193_fromFloat)
HXDLIN( 193)		return ::haxe::Int64Helper_obj::fromFloat(f);
            	}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(Int64_Impl__obj,fromFloat,return )


Int64_Impl__obj::Int64_Impl__obj()
{
}

bool Int64_Impl__obj::__GetStatic(const ::String &inName, Dynamic &outValue, ::hx::PropertyAccess inCallProp)
{
	switch(inName.length) {
	case 9:
		if (HX_FIELD_EQ(inName,"fromFloat") ) { outValue = fromFloat_dyn(); return true; }
	}
	return false;
}

#ifdef HXCPP_SCRIPTABLE
static ::hx::StorageInfo *Int64_Impl__obj_sMemberStorageInfo = 0;
static ::hx::StaticInfo *Int64_Impl__obj_sStaticStorageInfo = 0;
#endif

::hx::Class Int64_Impl__obj::__mClass;

static ::String Int64_Impl__obj_sStaticFields[] = {
	HX_("fromFloat",d2,af,1f,b7),
	::String(null())
};

void Int64_Impl__obj::__register()
{
	Int64_Impl__obj _hx_dummy;
	Int64_Impl__obj::_hx_vtable = *(void **)&_hx_dummy;
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("haxe._Int64.Int64_Impl_",15,d6,6c,a0);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mConstructEmpty = &__CreateEmpty;
	__mClass->mConstructArgs = &__Create;
	__mClass->mGetStaticField = &Int64_Impl__obj::__GetStatic;
	__mClass->mSetStaticField = &::hx::Class_obj::SetNoStaticField;
	__mClass->mStatics = ::hx::Class_obj::dupFunctions(Int64_Impl__obj_sStaticFields);
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(0 /* sMemberFields */);
	__mClass->mCanCast = ::hx::TCanCast< Int64_Impl__obj >;
#ifdef HXCPP_SCRIPTABLE
	__mClass->mMemberStorageInfo = Int64_Impl__obj_sMemberStorageInfo;
#endif
#ifdef HXCPP_SCRIPTABLE
	__mClass->mStaticStorageInfo = Int64_Impl__obj_sStaticStorageInfo;
#endif
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace haxe
} // end namespace _Int64