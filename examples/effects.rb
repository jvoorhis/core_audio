require 'core_audio'

graph = AudioToolbox::AUGraph.new
mus = graph.nodes.add(:type => 'aumu', :sub_type => 'dls ', :manufacturer => 'appl')
del = graph.nodes.add(:type => 'aufx', :sub_type => 'dely', :manufacturer => 'appl')
rev = graph.nodes.add(:type => 'aufx', :sub_type => 'mrev', :manufacturer => 'appl')
out = graph.nodes.add(:type => 'auou', :sub_type => 'def ', :manufacturer => 'appl')

graph.connect_node_input(mus, 0, del, 0)
graph.connect_node_input(del, 0, rev, 0)
graph.connect_node_input(rev, 0, out, 0)
graph.open
graph.init
graph.show
graph.start

dls = mus.audio_unit
dls.note_on(0, 60, 127)
sleep 0.4
dls.note_on(0, 64, 127)
sleep 0.4
dls.note_on(0, 67, 127)
sleep 0.4
dls.note_on(0, 72, 127)
sleep 2
dls.note_off(0, 60)
dls.note_off(0, 64)
dls.note_off(0, 67)
dls.note_off(0, 72)
sleep 6

graph.stop
graph.dispose
