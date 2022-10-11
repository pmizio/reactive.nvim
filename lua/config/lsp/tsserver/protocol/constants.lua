return {
  CommandTypes = {
    JsxClosingTag = "jsxClosingTag",
    Brace = "brace",
    BraceCompletion = "braceCompletion",
    GetSpanOfEnclosingComment = "getSpanOfEnclosingComment",
    Change = "change",
    Close = "close",
    ---@deprecated Prefer CompletionInfo -- see comment on CompletionsResponse
    Completions = "completions",
    CompletionInfo = "completionInfo",
    CompletionDetails = "completionEntryDetails",
    CompileOnSaveAffectedFileList = "compileOnSaveAffectedFileList",
    CompileOnSaveEmitFile = "compileOnSaveEmitFile",
    Configure = "configure",
    Definition = "definition",
    DefinitionAndBoundSpan = "definitionAndBoundSpan",
    Implementation = "implementation",
    Exit = "exit",
    FileReferences = "fileReferences",
    Format = "format",
    Formatonkey = "formatonkey",
    Geterr = "geterr",
    GeterrForProject = "geterrForProject",
    SemanticDiagnosticsSync = "semanticDiagnosticsSync",
    SyntacticDiagnosticsSync = "syntacticDiagnosticsSync",
    SuggestionDiagnosticsSync = "suggestionDiagnosticsSync",
    NavBar = "navbar",
    Navto = "navto",
    NavTree = "navtree",
    NavTreeFull = "navtree-full",
    ---@deprecated
    Occurrences = "occurrences",
    DocumentHighlights = "documentHighlights",
    Open = "open",
    Quickinfo = "quickinfo",
    References = "references",
    Reload = "reload",
    Rename = "rename",
    Saveto = "saveto",
    SignatureHelp = "signatureHelp",
    FindSourceDefinition = "findSourceDefinition",
    Status = "status",
    TypeDefinition = "typeDefinition",
    ProjectInfo = "projectInfo",
    ReloadProjects = "reloadProjects",
    Unknown = "unknown",
    OpenExternalProject = "openExternalProject",
    OpenExternalProjects = "openExternalProjects",
    CloseExternalProject = "closeExternalProject",
    UpdateOpen = "updateOpen",
    GetOutliningSpans = "getOutliningSpans",
    TodoComments = "todoComments",
    Indentation = "indentation",
    DocCommentTemplate = "docCommentTemplate",
    CompilerOptionsForInferredProjects = "compilerOptionsForInferredProjects",
    GetCodeFixes = "getCodeFixes",
    GetCombinedCodeFix = "getCombinedCodeFix",
    ApplyCodeActionCommand = "applyCodeActionCommand",
    GetSupportedCodeFixes = "getSupportedCodeFixes",
    GetApplicableRefactors = "getApplicableRefactors",
    GetEditsForRefactor = "getEditsForRefactor",
    OrganizeImports = "organizeImports",
    GetEditsForFileRename = "getEditsForFileRename",
    ConfigurePlugin = "configurePlugin",
    SelectionRange = "selectionRange",
    ToggleLineComment = "toggleLineComment",
    ToggleMultilineComment = "toggleMultilineComment",
    CommentSelection = "commentSelection",
    UncommentSelection = "uncommentSelection",
    PrepareCallHierarchy = "prepareCallHierarchy",
    ProvideCallHierarchyIncomingCalls = "provideCallHierarchyIncomingCalls",
    ProvideCallHierarchyOutgoingCalls = "provideCallHierarchyOutgoingCalls",
    ProvideInlayHints = "provideInlayHints",
  },
  ScriptElementKind = {
    unknown = "",
    warning = "warning",
    -- predefined type (void) or keyword (class)
    keyword = "keyword",
    -- top level script node
    scriptElement = "script",
    -- module foo {}
    moduleElement = "module",
    -- class X {}
    classElement = "class",
    -- var x = class X {}
    localClassElement = "local class",
    -- interface Y {}
    interfaceElement = "interface",
    -- type T = ...
    typeElement = "type",
    -- enum E
    enumElement = "enum",
    enumMemberElement = "enum member",
    --[[
    Inside module and script only
    const v = ..
    --]]
    variableElement = "var",
    -- Inside function
    localVariableElement = "local var",
    --[[
    Inside module and script only
    function f() { }
    --]]
    functionElement = "function",
    -- Inside function
    localFunctionElement = "local function",
    -- class X { [public|private]* foo() {} }
    memberFunctionElement = "method",
    -- class X { [public|private]* [get|set] foo:number; }
    memberGetAccessorElement = "getter",
    memberSetAccessorElement = "setter",
    --[[
    class X { [public|private]* foo:number; }
    interface Y { foo:number; }
    --]]
    memberVariableElement = "property",
    --[[
    class X { constructor() { } }
    class X { static { } }
    --]]
    constructorImplementationElement = "constructor",
    -- interface Y { ():number; }
    callSignatureElement = "call",
    -- interface Y { []:number; }
    indexSignatureElement = "index",
    -- interface Y { new():Y; }
    constructSignatureElement = "construct",
    -- function foo(*Y*: string)
    parameterElement = "parameter",
    typeParameterElement = "type parameter",
    primitiveType = "primitive type",
    label = "label",
    alias = "alias",
    constElement = "const",
    letElement = "let",
    directory = "directory",
    externalModuleName = "external module name",
    -- <JsxTagName attribute1 attribute2={0} />
    ---@deprecated
    jsxAttribute = "JSX attribute",
    -- String literal
    string = "string",
    -- Jsdoc @link: in `{@link C link text}`, the before and after text "{@link " and "}"
    link = "link",
    -- Jsdoc @link: in `{@link C link text}`, the entity name "C"
    linkName = "link name",
    -- Jsdoc @link: in `{@link C link text}`, the link text "link text"
    linkText = "link text",
  },
  ScriptKindName = {
    TS = "TS",
    JS = "JS",
    TSX = "TSX",
    JSX = "JSX",
  },
  LspMethods = {
    Initialize = "initialize",
    DidOpen = "textDocument/didOpen",
    DidClose = "textDocument/didClose",
    DidChange = "textDocument/didChange",
    Rename = "textDocument/rename",
    Completion = "textDocument/completion",
    CompletionResolve = "completionItem/resolve",
  },
  CompletionItemKind = {
    Text = 1,
    Method = 2,
    Function = 3,
    Constructor = 4,
    Field = 5,
    Variable = 6,
    Class = 7,
    Interface = 8,
    Module = 9,
    Property = 10,
    Unit = 11,
    Value = 12,
    Enum = 13,
    Keyword = 14,
    Snippet = 15,
    Color = 16,
    File = 17,
    Reference = 18,
    Folder = 19,
    EnumMember = 20,
    Constant = 21,
    Struct = 22,
    Event = 23,
    Operator = 24,
    TypeParameter = 25,
  },
  InsertTextFormat = {
    PlainText = 1,
    Snippet = 2,
  },
  MarkupKind = {
    PlainText = "plaintext",
    Markdown = "markdown",
  },
}
