%% This is the application resource file (.app file) for the 'base'
%% application.
{application, webflow_proto,
[{description, "webflow_proto  " },
{vsn, "1.0.0" },
{modules, 
	  [webflow_proto_app,webflow_proto_sup,webflow_proto]},
{registered,[webflow_proto]},
{applications, [kernel,stdlib]},
{mod, {webflow_proto_app,[]}},
{start_phases, []}
]}.
