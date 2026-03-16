<script lang="ts">
	import type { EdraTheme, EdraMode } from '../../../types.js';
	import Sun from '@lucide/svelte/icons/sun';
	import Moon from '@lucide/svelte/icons/moon';
	import Palette from '@lucide/svelte/icons/palette';

	interface Props {
		theme?: EdraTheme;
		mode?: EdraMode;
		onThemeChange?: (theme: EdraTheme) => void;
		onModeChange?: (mode: EdraMode) => void;
	}

	const {
		theme = 'default',
		mode = 'light',
		onThemeChange,
		onModeChange
	}: Props = $props();

	const themes: { value: EdraTheme; label: string }[] = [
		{ value: 'default', label: 'Default' },
		{ value: 'ocean', label: 'Ocean' },
		{ value: 'forest', label: 'Forest' },
		{ value: 'inherit', label: 'Inherit' }
	];

	const toggleMode: EdraMode = $derived(mode === 'light' ? 'dark' : 'light');
</script>

<div class="edra-theme-selector">
	<div class="edra-theme-selector-icon">
		<Palette size={15} />
	</div>
	<select
		class="edra-theme-selector-select"
		value={theme}
		onchange={(e) => onThemeChange?.((e.target as HTMLSelectElement).value as EdraTheme)}
		title="Choose theme"
	>
		{#each themes as t (t.value)}
			<option value={t.value}>{t.label}</option>
		{/each}
	</select>

	{#if theme !== 'inherit'}
		<button
			class="edra-command-button edra-theme-mode-toggle"
			onclick={() => onModeChange?.(toggleMode)}
			title={mode === 'light' ? 'Switch to dark mode' : 'Switch to light mode'}
		>
			{#if mode === 'light'}
				<Moon class="edra-toolbar-icon" />
			{:else}
				<Sun class="edra-toolbar-icon" />
			{/if}
		</button>
	{/if}
</div>

<style>
	.edra-theme-selector {
		display: inline-flex;
		align-items: center;
		gap: 0.25rem;
	}

	.edra-theme-selector-icon {
		display: flex;
		align-items: center;
		color: var(--edra-icon-color, currentColor);
		opacity: 0.7;
	}

	.edra-theme-selector-select {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		border: none;
		background-color: var(--edra-button-bg-color, transparent);
		border-radius: var(--edra-button-border-radius, 0.375rem);
		cursor: pointer;
		transition: background-color 0.2s ease-in-out;
		padding: var(--edra-button-padding, 0.375rem) 0.25rem;
		min-height: var(--edra-button-size, 2rem);
		font-size: 0.8125rem;
		color: var(--edra-icon-color, currentColor);
	}

	.edra-theme-selector-select:hover {
		background-color: var(--edra-button-hover-bg-color, #80808020);
	}

	.edra-theme-mode-toggle {
		padding: 0.25rem;
	}
</style>
