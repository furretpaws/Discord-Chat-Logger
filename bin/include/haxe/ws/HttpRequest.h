// Generated by Haxe 4.3.1
#ifndef INCLUDED_haxe_ws_HttpRequest
#define INCLUDED_haxe_ws_HttpRequest

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS1(haxe,IMap)
HX_DECLARE_CLASS2(haxe,ds,StringMap)
HX_DECLARE_CLASS2(haxe,ws,HttpRequest)

namespace haxe{
namespace ws{


class HXCPP_CLASS_ATTRIBUTES HttpRequest_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef HttpRequest_obj OBJ_;
		HttpRequest_obj();

	public:
		enum { _hx_ClassId = 0x601efbc5 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="haxe.ws.HttpRequest")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"haxe.ws.HttpRequest"); }
		static ::hx::ObjectPtr< HttpRequest_obj > __new();
		static ::hx::ObjectPtr< HttpRequest_obj > __alloc(::hx::Ctx *_hx_ctx);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~HttpRequest_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("HttpRequest",87,04,98,0d); }

		::String method;
		::String uri;
		::String httpVersion;
		 ::haxe::ds::StringMap headers;
		void addLine(::String line);
		::Dynamic addLine_dyn();

		::String build();
		::Dynamic build_dyn();

		virtual ::String toString();
		::Dynamic toString_dyn();

};

} // end namespace haxe
} // end namespace ws

#endif /* INCLUDED_haxe_ws_HttpRequest */ 