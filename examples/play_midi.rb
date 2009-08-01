require 'core_audio'

graph = AudioToolbox::AUGraph.new
graph.add_node(:type => 'aumu', :sub_type => 'dls ', :manufacturer => 'appl')
graph.add_node(:type => 'auou', :sub_type => 'def ', :manufacturer => 'appl')

mus = graph.node_at(0)
out = graph.node_at(1)
graph.connect_node_input(mus, 0, out, 0)
graph.update
graph.open
graph.init
graph.show

begin
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
rescue => e
  puts e.class.name, e.message, e.backtrace
ensure
  graph.stop
  graph.dispose
end
