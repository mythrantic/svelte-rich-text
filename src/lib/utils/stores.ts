import type { dataBlock } from './consts.js';

// Svelte 5 reactive state
export let data = $state<dataBlock[]>([]);

export let workingBlock = $state<{ state: 'focused' | 'editing'; id: string } | null>(null);
