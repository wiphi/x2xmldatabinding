unit DelphiXMLDataBindingResources;

interface
type
  TDelphiXMLSection = (dxsForward, dxsInterface, dxsClass, dxsImplementation);
  TDelphiXMLMember = (dxmPropertyGet, dxmPropertySet, dxmPropertyDeclaration);
  TDelphiAccessor = (daGet, daSet);
  TDelphiNodeType = (dntElement, dntAttribute, dntNodeValue, dntCustom);


const
  CrLf  = #13#10;
  
  UnitHeader          = '{'                                                     + CrLf +
                        '  X2Software XML Data Binding'                         + CrLf +
                        ''                                                      + CrLf +
                        '    Generated on:   %<DateTime>:s'                     + CrLf +
                        '    Generated from: %<SourceFileName>:s'               + CrLf +
                        '}'                                                     + CrLf +
                        'unit %<UnitName>:s;'                                   + CrLf +
                        ''                                                      + CrLf;

  UnitInterface       = 'interface'                                             + CrLf +
                        'uses'                                                  + CrLf +
                        '%<UsesClause>:s'                                       +
                        '  Classes,'                                            + CrLf +
                        '  XMLDoc,'                                             + CrLf +
                        '  XMLIntf;'                                            + CrLf +
                        ''                                                      + CrLf +
                        'type'                                                  + CrLf;

  UnitImplementation  = 'implementation'                                        + CrLf;

  UnitFooter          = ''                                                      + CrLf +
                        'end.'                                                  + CrLf;



  DocumentBinding                 = 'GetDocBinding(''%<SourceName>:s'', TXML%<Name>:s, TargetNamespace) as IXML%<Name>:s';

  DocumentFunctionsInterface      = '  function Get%<Name>:s(ADocument: XMLIntf.IXMLDocument): IXML%<Name>:s;'  + CrLf +
                                    '  function Load%<Name>:s(const AFileName: String): IXML%<Name>:s;'         + CrLf +
                                    '  function Load%<Name>:sFromStream(AStream: TStream): IXML%<Name>:s;'      + CrLf +
                                    '  function New%<Name>:s: IXML%<Name>:s;'                                   + CrLf;

  DocumentFunctionsImplementation = 'function Get%<Name>:s(ADocument: XMLIntf.IXMLDocument): IXML%<Name>:s;'  + CrLf +
                                    'begin'                                                                   + CrLf +
                                    '  Result := ADocument.' + DocumentBinding                                + CrLf +
                                    'end;'                                                                    + CrLf +
                                    ''                                                                        + CrLf +
                                    'function Load%<Name>:s(const AFileName: String): IXML%<Name>:s;'         + CrLf +
                                    'begin'                                                                   + CrLf +
                                    '  Result := LoadXMLDocument(AFileName).' + DocumentBinding               + CrLf +
                                    'end;'                                                                    + CrLf +
                                    ''                                                                        + CrLf +
                                    'function Load%<Name>:sFromStream(AStream: TStream): IXML%<Name>:s;'      + CrLf +
                                    'var'                                                                     + CrLf +
                                    '  doc: XMLIntf.IXMLDocument;'                                            + CrLf +
                                    ''                                                                        + CrLf +
                                    'begin'                                                                   + CrLf +
                                    '  doc := NewXMLDocument;'                                                + CrLf +
                                    '  doc.LoadFromStream(AStream);'                                          + CrLf +
                                    '  Result  := Get%<Name>:s(doc);'                                         + CrLf +
                                    'end;'                                                                    + CrLf +
                                    ''                                                                        + CrLf +
                                    'function New%<Name>:s: IXML%<Name>:s;'                                   + CrLf +
                                    'begin'                                                                   + CrLf +
                                    '  Result := NewXMLDocument.' + DocumentBinding                           + CrLf +
                                    'end;'                                                                    + CrLf +
                                    ''                                                                        + CrLf;


  PropertyIntfMethodGetOptional = '    function GetHas%<PropertyName>:s: Boolean;';
  PropertyIntfMethodGetNil      = '    function Get%<PropertyName>:sIsNil: Boolean;';
  PropertyIntfMethodGetText     = '    function Get%<PropertyName>:sText: WideString;';
  PropertyIntfMethodGet         = '    function Get%<PropertyName>:s: %<DataType>:s;';
  PropertyIntfMethodSetNil      = '    procedure Set%<PropertyName>:sIsNil(const Value: Boolean);';
  PropertyIntfMethodSetText     = '    procedure Set%<PropertyName>:sText(const Value: WideString);';
  PropertyIntfMethodSet         = '    procedure Set%<PropertyName>:s(const Value: %<DataType>:s);';

  PropertyInterfaceOptional     = '    property Has%<PropertyName>:s: Boolean read GetHas%<PropertyName>:s;';
  PropertyInterfaceNilReadOnly  = '    property %<PropertyName>:sIsNil: Boolean read Get%<PropertyName>:sIsNil;';
  PropertyInterfaceNil          = '    property %<PropertyName>:sIsNil: Boolean read Get%<PropertyName>:sIsNil write Set%<PropertyName>:sIsNil;';
  PropertyInterfaceTextReadOnly = '    property %<PropertyName>:sText: WideString read Get%<PropertyName>:sText;';
  PropertyInterfaceReadOnly     = '    property %<PropertyName>:s: %<DataType>:s read Get%<PropertyName>:s;';
  PropertyInterfaceText         = '    property %<PropertyName>:sText: WideString read Get%<PropertyName>:sText write Set%<PropertyName>:sText;';
  PropertyInterface             = '    property %<PropertyName>:s: %<DataType>:s read Get%<PropertyName>:s write Set%<PropertyName>:s;';

  PropertyImplMethodGetOptional = 'function TXML%<Name>:s.GetHas%<PropertyName>:s: Boolean;'                + CrLf +
                                  'begin'                                                                   + CrLf +
                                  '  Result := Assigned(ChildNodes.FindNode(''%<PropertySourceName>:s''));' + CrLf +
                                  'end;'                                                                    + CrLf +
                                  ''                                                                        + CrLf;

  PropertyImplMethodGetOptionalAttr = 'function TXML%<Name>:s.GetHas%<PropertyName>:s: Boolean;'                + CrLf +
                                      'begin'                                                                   + CrLf +
                                      '  Result := Assigned(AttributeNodes.FindNode(''%<PropertySourceName>:s''));' + CrLf +
                                      'end;'                                                                    + CrLf +
                                      ''                                                                        + CrLf;

  PropertyImplMethodGetNil      = 'function TXML%<Name>:s.Get%<PropertyName>:sIsNil: Boolean;'                                + CrLf +
                                  'begin'                                                                                     + CrLf +
                                  '  Result := GetNodeIsNil(ChildNodes[''%<PropertySourceName>:s'']);'                        + CrLf +
                                  'end;'                                                                                      + CrLf +
                                  ''                                                                                          + CrLf;

  PropertyImplMethodSetNil      = 'procedure TXML%<Name>:s.Set%<PropertyName>:sIsNil(const Value: Boolean);'    + CrLf +
                                  'begin'                                                                       + CrLf +
                                  '  SetNodeIsNil(ChildNodes[''%<PropertySourceName>:s''], Value);'             + CrLf +
                                  'end;'                                                                        + CrLf +
                                  ''                                                                            + CrLf;

  PropertyImplMethodGetText     = 'function TXML%<Name>:s.Get%<PropertyName>:sText: WideString;'            + CrLf +
                                  'begin'                                                                   + CrLf +
                                  '  Result := ChildNodes[''%<PropertySourceName>:s''].Text;'               + CrLf +
                                  'end;'                                                                    + CrLf +
                                  ''                                                                        + CrLf;

  PropertyImplMethodGetTextAttr = 'function TXML%<Name>:s.Get%<PropertyName>:sText: WideString;'            + CrLf +
                                  'begin'                                                                   + CrLf +
                                  '  Result := AttributeNodes[''%<PropertySourceName>:s''].Text;'               + CrLf +
                                  'end;'                                                                    + CrLf +
                                  ''                                                                        + CrLf;

  PropertyImplMethodSetText     = 'procedure TXML%<Name>:s.Set%<PropertyName>:sText(const Value: WideString);'  + CrLf +
                                  'begin'                                                                       + CrLf +
                                  '  ChildNodes[''%<PropertySourceName>:s''].NodeValue := Value;'               + CrLf +
                                  'end;'                                                                        + CrLf +
                                  ''                                                                            + CrLf;

  PropertyImplMethodSetTextAttr = 'procedure TXML%<Name>:s.Set%<PropertyName>:sText(const Value: WideString);'  + CrLf +
                                  'begin'                                                                       + CrLf +
                                  '  AttributeNodes[''%<PropertySourceName>:s''].NodeValue := Value;'               + CrLf +
                                  'end;'                                                                        + CrLf +
                                  ''                                                                            + CrLf;


  SectionComments:  array[TDelphiXMLSection] of String =
                    (
                      '  { Forward declarations for %<SchemaName>:s }',
                      '  { Interfaces for %<SchemaName>:s }',
                      '  { Classes for %<SchemaName>:s }',
                      '{ Implementation for %<SchemaName>:s }'
                    );




  PrefixInterface         = 'IXML';
  PrefixClass             = 'TXML';
  PrefixField             = 'F';


  InterfaceItemForward    = '  IXML%<Name>:s = interface;';
  InterfaceItemInterface  = '  IXML%<Name>:s = interface(%<ParentName>:s)';
  InterfaceItemClass      = '  TXML%<Name>:s = class(%<ParentName>:s, IXML%<Name>:s)';


  CollectionInterface     = 'IXMLNodeCollection';
  CollectionClass         = 'TXMLNodeCollection';

  ItemInterface           = 'IXMLNode';
  ItemClass               = 'TXMLNode';



  // #ToDo1 (MvR) 9-3-2008: document / node / etc
  // #ToDo1 (MvR) 9-3-2008: WideString etc ?
  ReservedWords:  array[0..106] of String =
                  (
                    'absolute', 'abstract', 'and', 'array', 'as', 'asm',
                    'assembler', {'automated', }'begin', 'case', 'cdecl', 'class',
                    'const', 'constructor', {'contains', }'default', 'deprecated',
                    'destructor', 'dispid', 'dispinterface', 'div', 'do',
                    'downto', 'dynamic', 'else', 'end', 'except', 'export',
                    'exports', 'external', 'far', {'file', 'final', }'finalization',
                    'finally', 'for', 'forward', 'function', 'goto', 'if',
                    'implementation', 'implements', 'in', 'index', 'inherited',
                    'initialization', 'inline', 'interface', 'is', 'label',
                    'library', 'local', 'message', 'mod', {'name', }'near',
                    'nil', 'nodefault', 'not', 'object', 'of', 'or', 'out',
                    'overload', 'override', 'package', 'packed', 'pascal',
                    'platform', 'private', 'procedure', 'program', 'property',
                    'protected', 'public', 'published', 'raise', 'read',
                    'readonly', 'record', 'register', 'reintroduce', 'repeat',
                    'requires', 'resident', 'resourcestring', 'safecall',
                    'sealed', 'set', 'shl', 'shr', 'static', 'stdcall',
                    'stored', 'string', 'then', 'threadvar', 'to', 'try', 'type',
                    'unit', 'unsafe', 'until', 'uses', 'var', 'varargs',
                    'virtual', 'while', 'with', 'write', 'writeonly', 'xor'
                  );

  SafeChars = ['A'..'Z', 'a'..'z', '0'..'9', '_', '-'];


type
  TTypeConversion   = (tcNone,
                       tcBoolean,
                       tcFloat,
                       tcDateTime,
                       tcDate,
                       tcTime,
                       tcString,
                       tcBase64);
                       
  TTypeConversions  = set of TTypeConversion;

  TTypeMapping  = record
    SchemaName:   String;
    DelphiName:   String;
    Conversion:   TTypeConversion;
  end;


const
  SimpleTypeMapping:  array[0..11] of TTypeMapping =
                      (
                        (SchemaName:  'int';          DelphiName:  'Integer';     Conversion:    tcNone),
                        (SchemaName:  'integer';      DelphiName:  'Integer';     Conversion:    tcNone),
                        (SchemaName:  'short';        DelphiName:  'Smallint';    Conversion:    tcNone),
                        (SchemaName:  'date';         DelphiName:  'TDateTime';   Conversion:    tcDate),
                        (SchemaName:  'time';         DelphiName:  'TDateTime';   Conversion:    tcTime),
                        (SchemaName:  'dateTime';     DelphiName:  'TDateTime';   Conversion:    tcDateTime),
                        (SchemaName:  'float';        DelphiName:  'Double';      Conversion:    tcFloat),
                        (SchemaName:  'double';       DelphiName:  'Double';      Conversion:    tcFloat),
                        (SchemaName:  'boolean';      DelphiName:  'Boolean';     Conversion:    tcBoolean),
                        (SchemaName:  'string';       DelphiName:  'WideString';  Conversion:    tcString),
                        (SchemaName:  'anyURI';       DelphiName:  'WideString';  Conversion:    tcString),
                        (SchemaName:  'base64Binary'; DelphiName:  'WideString';  Conversion:    tcBase64)
                      );


  TypeConversionReqUtils:   array[TTypeConversion] of Boolean =
                            (
                              { tcNone }      False,
                              { tcBoolean }   True,
                              { tcFloat }     True,
                              { tcDateTime }  True,
                              { tcDate }      True,
                              { tcTime }      True,
                              { tcString }    False,
                              { tcBase64 }    True
                            );

  TypeConversionNone:       array[TDelphiAccessor, TDelphiNodeType] of String =
                            (
                              { daGet }
                              (
                                { dntElement }    '  %<Destination>:s := ChildNodes[''%<Source>:s''].NodeValue;',
                                { dntAttribute }  '  %<Destination>:s := AttributeNodes[''%<Source>:s''].NodeValue;',
                                { dntNodeValue }  '  %<Destination>:s := NodeValue;',
                                { dntCustom }     '  %<Destination>:s := %<Source>:s;'
                              ),
                              { daSet }
                              (
                                { dntElement }    '  ChildNodes[''%<Destination>:s''].NodeValue := %<Source>:s;',
                                { dntAttribute }  '  SetAttribute(''%<Destination>:s'', %<Source>:s);',
                                { dntNodeValue }  '  NodeValue := %<Source>:s;',
                                { dntCustom }     '  %<Destination>:s := %<Source>:s;'
                              )
                            );


  TypeConversion:           array[TDelphiAccessor, TDelphiNodeType, TTypeConversion] of String =
                            (
                              { daGet }
                              (
                                { dntElement }
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '',
                                  { tcFloat }     '  %<Destination>:s := XMLToFloat(ChildNodes[''%<Source>:s''].NodeValue);',
                                  { tcDateTime }  '  %<Destination>:s := XMLToDateTime(ChildNodes[''%<Source>:s''].NodeValue, xdtDateTime);',
                                  { tcDate }      '  %<Destination>:s := XMLToDateTime(ChildNodes[''%<Source>:s''].NodeValue, xdtDate);',
                                  { tcTime }      '  %<Destination>:s := XMLToDateTime(ChildNodes[''%<Source>:s''].NodeValue, xdtTime);',
                                  { tcString }    '  %<Destination>:s := ChildNodes[''%<Source>:s''].Text;',
                                  { tcBas64 }     '  %<Destination>:s := Base64Decode(Trim(ChildNodes[''%<Source>:s''].Text));'
                                ),
                                { dntAttribute }
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '',
                                  { tcFloat }     '  %<Destination>:s := XMLToFloat(AttributeNodes[''%<Source>:s''].NodeValue);',
                                  { tcDateTime }  '  %<Destination>:s := XMLToDateTime(AttributeNodes[''%<Source>:s''].NodeValue, xdtDateTime);',
                                  { tcDate }      '  %<Destination>:s := XMLToDateTime(AttributeNodes[''%<Source>:s''].NodeValue, xdtDate);',
                                  { tcTime }      '  %<Destination>:s := XMLToDateTime(AttributeNodes[''%<Source>:s''].NodeValue, xdtTime);',
                                  { tcString }    '  %<Destination>:s := AttributeNodes[''%<Source>:s''].Text;',
                                  { tcBase64 }    '  %<Destination>:s := Base64Decode(Trim(AttributeNodes[''%<Source>:s''].Text));'
                                ),
                                { dntNodeValue }
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '',
                                  { tcFloat }     '  %<Destination>:s := XMLToFloat(NodeValue);',
                                  { tcDateTime }  '  %<Destination>:s := XMLToDateTime(NodeValue, xdtDateTime);',
                                  { tcDate }      '  %<Destination>:s := XMLToDateTime(NodeValue, xdtDate);',
                                  { tcTime }      '  %<Destination>:s := XMLToDateTime(NodeValue, xdtTime);',
                                  { tcString }    '  %<Destination>:s := NodeValue;',
                                  { tcBase64 }    '  %<Destination>:s := Base64Decode(Trim(NodeValue));'
                                ),
                                { dntCustom}
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '',
                                  { tcFloat }     '  %<Destination>:s := XMLToFloat(%<Source>:s);',
                                  { tcDateTime }  '  %<Destination>:s := XMLToDateTime(%<Source>:s, xdtDateTime);',
                                  { tcDate }      '  %<Destination>:s := XMLToDateTime(%<Source>:s, xdtDate);',
                                  { tcTime }      '  %<Destination>:s := XMLToDateTime(%<Source>:s, xdtTime);',
                                  { tcString }    '',
                                  { tcBase64 }    '  %<Destination>:s := Base64Decode(Trim(%<Source>:s));'
                                )
                              ),
                              { daSet }
                              (
                                { dntElement }
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '  ChildNodes[''%<Destination>:s''].NodeValue := BoolToXML(%<Source>:s);',
                                  { tcFloat }     '  ChildNodes[''%<Destination>:s''].NodeValue := FloatToXML(%<Source>:s);',
                                  { tcDateTime }  '  ChildNodes[''%<Destination>:s''].NodeValue := DateTimeToXML(%<Source>:s, xdtDateTime);',
                                  { tcDate }      '  ChildNodes[''%<Destination>:s''].NodeValue := DateTimeToXML(%<Source>:s, xdtDate);',
                                  { tcTime }      '  ChildNodes[''%<Destination>:s''].NodeValue := DateTimeToXML(%<Source>:s, xdtTime);',
                                  { tcString }    '',
                                  { tcBase64 }    '  ChildNodes[''%<Destination>:s''].NodeValue := Base64Encode(%<Source>:s);'
                                ),
                                { dntAttribute }
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '  SetAttribute(''%<Destination>:s'', BoolToXML(%<Source>:s));',
                                  { tcFloat }     '  SetAttribute(''%<Destination>:s'', FloatToXML(%<Source>:s));',
                                  { tcDateTime }  '  SetAttribute(''%<Destination>:s'', DateTimeToXML(%<Source>:s, xdtDateTime));',
                                  { tcDate }      '  SetAttribute(''%<Destination>:s'', DateTimeToXML(%<Source>:s, xdtDate));',
                                  { tcTime }      '  SetAttribute(''%<Destination>:s'', DateTimeToXML(%<Source>:s, xdtTime));',
                                  { tcString }    '',
                                  { tcBase64 }    '  SetAttribute(''%<Destination>:s'', Base64Encode(%<Source>:s));'
                                ),
                                { dntNodeValue }
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '  NodeValue := BoolToXML(%<Source>:s);',
                                  { tcFloat }     '  NodeValue := FloatToXML(%<Source>:s);',
                                  { tcDateTime }  '  NodeValue := DateTimeToXML(%<Source>:s, xdtDateTime);',
                                  { tcDate }      '  NodeValue := DateTimeToXML(%<Source>:s, xdtDate);',
                                  { tcTime }      '  NodeValue := DateTimeToXML(%<Source>:s, xdtTime);',
                                  { tcString }    '',
                                  { tcBase64 }    '  NodeValue := Base64Encode(%<Source>:s);'
                                ),
                                { dntCustom}
                                (
                                  { tcNone }      '',
                                  { tcBoolean }   '  %<Destination>:s := BoolToXML(%<Source>:s);',
                                  { tcFloat }     '  %<Destination>:s := FloatToXML(%<Source>:s);',
                                  { tcDateTime }  '  %<Destination>:s := DateTimeToXML(%<Source>:s, xdtDateTime);',
                                  { tcDate }      '  %<Destination>:s := DateTimeToXML(%<Source>:s, xdtDate);',
                                  { tcTime }      '  %<Destination>:s := DateTimeToXML(%<Source>:s, xdtTime);',
                                  { tcString }    '',
                                  { tcBase64 }    '  %<Destination>:s := Base64Encode(%<Source>:s);'
                                )
                              )
                            );


implementation
end.

