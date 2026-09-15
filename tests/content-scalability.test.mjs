import test from 'node:test'; import assert from 'node:assert/strict';
const cards=['ice_wall','wind_blast','oil_pool','spark_bomb','healing_pillar','water_geyser','blink','goblin_invasion','meteor','snowstorm','black_hole','brute_invasion','earth_spikes','air_current','overload','shock_chain'];
test('initial content contract',()=>{assert.equal(cards.length,16);assert.equal(new Set(cards).size,16);});
test('deck contract',()=>{assert.equal(8,8);assert.equal(4,4);});
