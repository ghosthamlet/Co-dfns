GenRuntime←{
     ft←PointerType ArrayTypeV 0          ⍝ Pointer to array, clean_env arg 1
     et←PointerType ft 0                  ⍝ Pointer to frame
     it←Int32Type                         ⍝ clean_env arg 2 type
     vt←VoidType                          ⍝ clean_env return type
     cet←FunctionType vt(ft it)2 0      ⍝ clean_env type
     opf←FunctionType it((3⍴ft),et)4 0  ⍝ Operator Function signature
     two←GenFuncType ¯1                   ⍝ Some functions take only two args
     std←GenFuncType 0                    ⍝ Most take three
     opfp←PointerType opf 0               ⍝ Type of Opf argument to operator
     opa←(3⍴ft),opfp,et                   ⍝ Operator argument types
     opr←FunctionType it opa 5 0          ⍝ Operator type
     add←⍵{AddFunction ⍺⍺ ⍵ ⍺}           ⍝ Fn to add functions to the module
     _←cet add¨'clean_env' 'init_env'     ⍝ Add clean_env()
     _←two add¨'array_cp' 'array_free'    ⍝ Add the special ones
     _←std add¨APLRunts                   ⍝ Add the normal runtime
     _←opr add¨APLRtOps                   ⍝ Add the operators
     0 0⍴⍬                                ⍝ Hide our return result
 }