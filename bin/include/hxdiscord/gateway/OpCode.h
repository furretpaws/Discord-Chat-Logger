// Generated by Haxe 4.3.1
#ifndef INCLUDED_hxdiscord_gateway_OpCode
#define INCLUDED_hxdiscord_gateway_OpCode

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(hxdiscord,gateway,OpCode)

namespace hxdiscord{
namespace gateway{


class HXCPP_CLASS_ATTRIBUTES OpCode_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef OpCode_obj OBJ_;
		OpCode_obj();

	public:
		enum { _hx_ClassId = 0x22b8527e };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="hxdiscord.gateway.OpCode")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"hxdiscord.gateway.OpCode"); }

		inline static ::hx::ObjectPtr< OpCode_obj > __new() {
			::hx::ObjectPtr< OpCode_obj > __this = new OpCode_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< OpCode_obj > __alloc(::hx::Ctx *_hx_ctx) {
			OpCode_obj *__this = (OpCode_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(OpCode_obj), false, "hxdiscord.gateway.OpCode"));
			*(void **)__this = OpCode_obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~OpCode_obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("OpCode",0e,57,b0,3f); }

		static ::String checkOpCode(int op);
		static ::Dynamic checkOpCode_dyn();

};

} // end namespace hxdiscord
} // end namespace gateway

#endif /* INCLUDED_hxdiscord_gateway_OpCode */ 