import type { Content, Editor } from '@tiptap/core';
import type { EditorState } from '@tiptap/pm/state';
import type { EditorView } from '@tiptap/pm/view';
import type { Snippet } from 'svelte';
import type { Theme, ThemeMode } from '../../stores/theme.js';

export interface EdraEditorProps {
	content?: Content;
	editable?: boolean;
	editor?: Editor;
	autofocus?: boolean;
	onUpdate?: () => void;
	class?: string;
	theme?: Theme;
	themeMode?: ThemeMode;
}

export interface EdraToolbarProps {
	editor: Editor;
	class?: string;
	excludedCommands?: string[];
	children?: Snippet<[]>;
}

export interface ShouldShowProps {
	editor: Editor;
	element: HTMLElement;
	view: EditorView;
	state: EditorState;
	oldState?: EditorState;
	from: number;
	to: number;
}
