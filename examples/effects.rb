require 'core_audio'

graph = AudioToolbox::AUGraph.new
mus = graph.nodes.add(:aumu, :dls, :appl)
del = graph.nodes.add(:aufx, :dely, :appl)
rev = graph.nodes.add(:aufx, :mrev, :appl)
out = graph.nodes.add(:auou, :def, :appl)

graph.connect(mus, 0, del, 0)
graph.connect(del, 0, rev, 0)
graph.connect(rev, 0, out, 0)
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
