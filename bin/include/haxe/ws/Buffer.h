// Generated by Haxe 4.3.1
#ifndef INCLUDED_haxe_ws_Buffer
#define INCLUDED_haxe_ws_Buffer

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS2(haxe,io,Bytes)
HX_DECLARE_CLASS2(haxe,ws,Buffer)

namespace haxe{
namespace ws{


class HXCPP_CLASS_ATTRIBUTES Buffer_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef Buffer_obj OBJ_;
		Buffer_obj();

	public:
		enum { _hx_ClassId = 0x7bcd1196 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=true,const char *inName="haxe.ws.Buffer")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,true,"haxe.ws.Buffer"); }
		static ::hx::ObjectPtr< Buffer_obj > __new();
		static ::hx::ObjectPtr< Buffer_obj > __alloc(::hx::Ctx *_hx_ctx);
		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~Buffer_obj();

		HX_DO_RTTI_ALL;
		::hx::Val __Field(const ::String &inString, ::hx::PropertyAccess inCallProp);
		::hx::Val __SetField(const ::String &inString,const ::hx::Val &inValue, ::hx::PropertyAccess inCallProp);
		void __GetFields(Array< ::String> &outFields);
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		void __Visit(HX_VISIT_PARAMS);
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("Buffer",20,31,29,05); }

		int available;
		int length;
		int currentOffset;
		 ::haxe::io::Bytes currentData;
		::Array< ::Dynamic> chunks;
		void writeByte(int v);
		::Dynamic writeByte_dyn();

		void writeShort(int v);
		::Dynamic writeShort_dyn();

		void writeInt(int v);
		::Dynamic writeInt_dyn();

		void writeBytes( ::haxe::io::Bytes data);
		::Dynamic writeBytes_dyn();

		 ::haxe::io::Bytes readAllAvailableBytes();
		::Dynamic readAllAvailableBytes_dyn();

		::String readLine();
		::Dynamic readLine_dyn();

		::Array< ::String > readLinesUntil(::String delimiter);
		::Dynamic readLinesUntil_dyn();

		 ::haxe::io::Bytes readUntil(::String delimiter);
		::Dynamic readUntil_dyn();

		 ::haxe::io::Bytes readBytes(int count);
		::Dynamic readBytes_dyn();

		int readUnsignedShort();
		::Dynamic readUnsignedShort_dyn();

		int readUnsignedInt();
		::Dynamic readUnsignedInt_dyn();

		int readByte();
		::Dynamic readByte_dyn();

		int peekByte(int offset);
		::Dynamic peekByte_dyn();

		int peekUntil(int byte);
		::Dynamic peekUntil_dyn();

		bool endsWith(::String e);
		::Dynamic endsWith_dyn();

};

} // end namespace haxe
} // end namespace ws

#endif /* INCLUDED_haxe_ws_Buffer */ 