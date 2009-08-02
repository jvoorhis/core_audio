require 'core_audio'

graph = AudioToolbox::AUGraph.new
mus = graph.nodes.add(:type => :aumu, :sub_type => :dls, :manufacturer => :appl)
out = graph.nodes.add(:type => :auou, :sub_type => :def, :manufacturer => :appl)

graph.connect_node_input(mus, 0, out, 0)
graph.open
graph.init
graph.show
graph.start

dls = mus.audio_unit
dls.note_on(0, 60, 100)
sleep 0.4
dls.note_on(0, 64, 100)
sleep 0.4
dls.note_on(0, 67, 100)
sleep 0.4
dls.note_on(0, 72, 100)
sleep 2
dls.note_off(0, 60)
dls.note_off(0, 64)
dls.note_off(0, 67)
dls.note_off(0, 72)
sleep 1

graph.stop
graph.dispose
