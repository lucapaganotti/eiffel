indexing

	description:

		"Agent extension of GTK_DELETE_EVENT_SIGNAL_RECEIVER"

	copyright: "Copyright (c) 2003, Andreas Leitner and others"
	library: "EWG GTK+ 2 Library"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date: 2003/05/19 19:39:24 $"
	revision: "$Revision: 1.2 $"

class GTK_DELETE_EVENT_SIGNAL_RECEIVER_AGENT

inherit

	GTK_DELETE_EVENT_SIGNAL_RECEIVER
		rename
			make as make_internal
		end

	G_RECEIVER_AGENT_SKELETON [FUNCTION [ANY, TUPLE [GTK_WIDGET], BOOLEAN]]

creation

	make

feature {NONE}

	on_delete_event (a_widget: GTK_WIDGET): BOOLEAN is
		do
			Result := agent_.item ([a_widget])
		end
	
end
