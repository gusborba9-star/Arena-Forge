import { readFile } from 'node:fs/promises';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    const raw = await readFile(new URL('../../../../game/config/arena-forge-config.json', import.meta.url), 'utf8');
    const config = JSON.parse(raw);
    return NextResponse.json(config, {
      headers: {
        'Cache-Control': 'public, max-age=30, stale-while-revalidate=300',
      },
    });
  } catch {
    return NextResponse.json({ error: 'Arena Forge configuration unavailable' }, { status: 500 });
  }
}
