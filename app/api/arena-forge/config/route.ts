import { NextResponse } from 'next/server';
const config={schema_version:2,match:{max_energy:10,energy_regen_interval:1.5},deck:{size:8,hand_size:4},arena:{cataclysm_start_seconds:180,cataclysm_duration_seconds:60}};
export async function GET(){return NextResponse.json(config,{headers:{'Cache-Control':'public, max-age=30, stale-while-revalidate=300'}});}
