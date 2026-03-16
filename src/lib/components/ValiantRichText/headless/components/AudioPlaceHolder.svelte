<script lang="ts">
	import type { NodeViewProps } from '@tiptap/core';
	import { NodeViewWrapper } from 'svelte-tiptap';

	const { editor }: NodeViewProps = $props();
	import AudioLines from '@lucide/svelte/icons/audio-lines';
	import Link2 from '@lucide/svelte/icons/link';
	import Upload from '@lucide/svelte/icons/upload';

	let fileInput = $state<HTMLInputElement>();
	let activeTab = $state<'upload' | 'url'>('upload');
	let urlValue = $state('');

	function handleFileChange(e: Event) {
		const file = (e.target as HTMLInputElement).files?.[0];
		if (!file) return;
		const reader = new FileReader();
		reader.onload = (ev) => {
			const src = ev.target?.result as string;
			if (src) {
				editor.chain().focus().setAudio(src).run();
			}
		};
		reader.readAsDataURL(file);
	}

	function handleUrlInsert() {
		if (urlValue.trim()) {
			editor.chain().focus().setAudio(urlValue.trim()).run();
			urlValue = '';
		}
	}
</script>

<NodeViewWrapper>
	{#if editor.isEditable}
		<div class="edra-media-placeholder-wrapper edra-media-placeholder-tabs">
			<div class="edra-media-placeholder-icon-wrap">
				<AudioLines class="edra-media-placeholder-icon" />
				<span class="edra-media-placeholder-label">Audio</span>
			</div>
			<div class="edra-media-placeholder-actions">
				<button
					class={`edra-media-placeholder-tab ${activeTab === 'upload' ? 'active' : ''}`}
					onclick={() => (activeTab = 'upload')}
				>
					<Upload size={14} />
					Upload
				</button>
				<button
					class={`edra-media-placeholder-tab ${activeTab === 'url' ? 'active' : ''}`}
					onclick={() => (activeTab = 'url')}
				>
					<Link2 size={14} />
					URL
				</button>
			</div>
			{#if activeTab === 'upload'}
				<button
					class="edra-media-placeholder-upload-btn"
					onclick={() => fileInput?.click()}
				>
					Choose file
				</button>
				<input
					bind:this={fileInput}
					type="file"
					accept="audio/*"
					style="display:none"
					onchange={handleFileChange}
				/>
			{:else}
				<div class="edra-media-placeholder-url-row">
					<input
						class="edra-media-placeholder-url-input"
						type="url"
						placeholder="Paste audio URL…"
						bind:value={urlValue}
						onkeydown={(e) => e.key === 'Enter' && handleUrlInsert()}
					/>
					<button class="edra-media-placeholder-url-confirm" onclick={handleUrlInsert}>
						Insert
					</button>
				</div>
			{/if}
		</div>
	{/if}
</NodeViewWrapper>

<style>
	.edra-media-placeholder-tabs {
		flex-direction: column;
		align-items: flex-start;
		gap: 0.5rem;
		padding: 0.75rem 1rem;
		cursor: default;
	}

	.edra-media-placeholder-icon-wrap {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		color: var(--edra-muted-foreground, #808080);
	}

	.edra-media-placeholder-label {
		font-size: 0.875rem;
		font-weight: 500;
	}

	.edra-media-placeholder-actions {
		display: flex;
		gap: 0.25rem;
	}

	.edra-media-placeholder-tab {
		display: inline-flex;
		align-items: center;
		gap: 0.25rem;
		padding: 0.25rem 0.625rem;
		font-size: 0.8125rem;
		border-radius: 0.375rem;
		border: 1px solid var(--edra-border-color, #80808050);
		background: none;
		cursor: pointer;
		color: var(--edra-icon-color, currentColor);
		transition: background-color 0.15s;
	}

	.edra-media-placeholder-tab:hover,
	.edra-media-placeholder-tab.active {
		background-color: var(--edra-button-hover-bg-color, #80808020);
	}

	.edra-media-placeholder-tab.active {
		border-color: var(--edra-accent, #f97316);
		color: var(--edra-accent, #f97316);
	}

	.edra-media-placeholder-upload-btn {
		padding: 0.3rem 0.75rem;
		font-size: 0.8125rem;
		border-radius: 0.375rem;
		border: 1px solid var(--edra-border-color, #80808050);
		background: var(--edra-button-hover-bg-color, #80808020);
		cursor: pointer;
		color: var(--edra-icon-color, currentColor);
		transition: background-color 0.15s;
	}

	.edra-media-placeholder-upload-btn:hover {
		background-color: var(--edra-button-active-bg-color, #80808040);
	}

	.edra-media-placeholder-url-row {
		display: flex;
		gap: 0.375rem;
		width: 100%;
	}

	.edra-media-placeholder-url-input {
		flex: 1;
		padding: 0.3rem 0.5rem;
		font-size: 0.8125rem;
		border-radius: 0.375rem;
		border: 1px solid var(--edra-border-color, #80808050);
		background: none;
		color: var(--edra-icon-color, currentColor);
		outline: none;
	}

	.edra-media-placeholder-url-input:focus {
		border-color: var(--edra-accent, #f97316);
	}

	.edra-media-placeholder-url-confirm {
		padding: 0.3rem 0.625rem;
		font-size: 0.8125rem;
		border-radius: 0.375rem;
		background-color: var(--edra-accent, #f97316);
		color: var(--edra-accent-foreground, #fff);
		border: none;
		cursor: pointer;
		transition: opacity 0.15s;
	}

	.edra-media-placeholder-url-confirm:hover {
		opacity: 0.88;
	}
</style>

