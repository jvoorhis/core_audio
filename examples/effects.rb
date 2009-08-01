require 'core_audio'

graph = AudioToolbox::AUGraph.new
graph.add_node(:type => 'aumu', :sub_type => 'dls ', :manufacturer => 'appl')
graph.add_node(:type => 'aufx', :sub_type => 'dely', :manufacturer => 'appl')
graph.add_node(:type => 'aufx', :sub_type => 'mrev', :manufacturer => 'appl')
graph.add_node(:type => 'auou', :sub_type => 'def ', :manufacturer => 'appl')

mus = graph.node_at(0)
del = graph.node_at(1)
rev = graph.node_at(2)
out = graph.node_at(3)
graph.connect_node_input(mus, 0, del, 0)
graph.connect_node_input(del, 0, rev, 0)
graph.connect_node_input(rev, 0, out, 0)
graph.open
graph.init
graph.show
graph.start

dls = mus.audio_unit
dls.program_change(0, 96)
dls.note_on(0, 60, 110)
sleep 0.4
dls.note_on(0, 64, 110)
sleep 0.4
dls.note_on(0, 67, 110)
sleep 0.4
dls.note_on(0, 72, 110)
sleep 2
dls.note_off(0, 60)
dls.note_off(0, 64)
dls.note_off(0, 67)
dls.note_off(0, 72)
sleep 6

graph.stop
graph.dispose
