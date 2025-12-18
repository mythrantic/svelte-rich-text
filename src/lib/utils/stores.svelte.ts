import type { dataBlock } from './consts.js';

// Svelte 5 reactive state using runes
class DataStore {
	data = $state<dataBlock[]>([]);
	workingBlock = $state<{ state: 'focused' | 'editing'; id: string } | null>(null);
}

export const store = new DataStore();
