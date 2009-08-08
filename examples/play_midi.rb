require 'core_audio'

graph = AudioToolbox::AUGraph.new
mus = graph.nodes.add(:aumu, :sinz, :EECS)
out = graph.nodes.add(:auou, :def, :appl)

graph.connect(mus, 0, out, 0)
graph.open.init
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
