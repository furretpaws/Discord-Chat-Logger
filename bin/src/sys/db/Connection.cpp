// Generated by Haxe 4.3.1
#include <hxcpp.h>

#ifndef INCLUDED_sys_db_Connection
#include <sys/db/Connection.h>
#endif
#ifndef INCLUDED_sys_db_ResultSet
#include <sys/db/ResultSet.h>
#endif

namespace sys{
namespace db{


static ::String Connection_obj_sMemberFields[] = {
	HX_("request",4f,df,84,44),
	::String(null()) };

::hx::Class Connection_obj::__mClass;

void Connection_obj::__register()
{
	::hx::Static(__mClass) = new ::hx::Class_obj();
	__mClass->mName = HX_("sys.db.Connection",0d,6c,ac,5f);
	__mClass->mSuper = &super::__SGetClass();
	__mClass->mMembers = ::hx::Class_obj::dupFunctions(Connection_obj_sMemberFields);
	__mClass->mCanCast = ::hx::TIsInterface< (int)0x6e7a3d49 >;
	::hx::_hx_RegisterClass(__mClass->mName, __mClass);
}

} // end namespace sys
} // end namespace db