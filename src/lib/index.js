// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck
import { store } from './utils/stores.svelte';
export { default as ValiantRichText } from './components/core/main.svelte';

export function getData() {
	return store.data;
}

export function setData(newData) {
	store.data = newData;
}
