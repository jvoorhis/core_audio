require 'core_audio'

graph = AudioToolbox::AUGraph.new

cd = ComponentManager::ComponentDescription.new
cd[:componentType] = 'aumu'.to_ostype
cd[:componentSubType] = 'dls '.to_ostype
cd[:componentManufacturer] = 'appl'.to_ostype
cd[:componentFlags] = cd[:componentFlagsMask] = 0
graph.add_node(cd)

cd[:componentType] = 'auou'.to_ostype
cd[:componentSubType] = 'def '.to_ostype
graph.add_node(cd)

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
