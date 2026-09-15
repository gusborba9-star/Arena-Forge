import { NextResponse } from 'next/server';
export async function GET() { return NextResponse.json({ service: 'arena-forge', status: 'ok' }); }
