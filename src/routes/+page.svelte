<script>
	import { browser } from '$app/environment';
	import { ValiantRichText } from '$lib/index.js';
	import defaultContent from '$lib/default_content.js';

	// Editor states
	let content = $state();
	let editor = $state();

	$effect(() => {
		if (content) {
			localStorage.setItem('edra-content', JSON.stringify(content));
		}
	});

	if (browser) {
		const rawDataString = localStorage.getItem('edra-content');

		if (rawDataString === null) {
			content = defaultContent;
		} else {
			const rawData = JSON.parse(rawDataString);
			content = rawData;
		}
	}

	function onUpdate() {
		content = editor?.getJSON();
	}
</script>

<div class="landing">
	<!-- Hero Section -->
	<section class="hero">
		<div class="hero-content">
			<h1 class="hero-title">Svelte Rich Text Editor</h1>
			<p class="hero-subtitle">
				A powerful, flexible rich text editor for Svelte 5 applications. Built on Tiptap with full
				TypeScript support.
			</p>
			<div class="hero-buttons">
				<a href="/docs" class="btn btn-primary">Get Started</a>
				<a href="https://github.com/mythrantic/svelte-rich-text" class="btn btn-secondary"
					>View on GitHub</a
				>
			</div>
		</div>
	</section>

	<!-- Live Demo Section -->
	<section class="demo">
		<h2 class="section-title">Try It Live</h2>
		<p class="demo-subtitle">Experience the editor in action. Start typing to see the magic!</p>

		<div class="demo-container">
			<div class="demo-editor">
				<h3>Interactive Editor</h3>
				<div class="editor-wrapper">
					<ValiantRichText bind:editor {content} {onUpdate} editable={true} />
				</div>
			</div>

			<div class="demo-preview">
				<h3>Read-Only Preview</h3>
				<div class="preview-wrapper">
					<ValiantRichText {content} editable={false} />
				</div>
			</div>
		</div>
	</section>

	<!-- CTA Section -->
	<section class="cta">
		<div class="cta-content">
			<h2>Ready to Get Started?</h2>
			<p>Install with npm, pnpm, or yarn and start building amazing content experiences.</p>
			<div class="code-block">
				<code>npm install @mythrantic/svelte-rich-text</code>
			</div>
			<a href="/docs" class="btn btn-primary btn-large">Read the Documentation</a>
		</div>
	</section>

	<!-- Footer -->
	<footer class="footer">
		<div class="footer-content">
			<p>
				Built using <a href="https://svelte.dev">Svelte 5</a> and
				<a href="https://tiptap.dev">Tiptap</a>
			</p>
			<div class="footer-links">
				<a href="/docs">Documentation</a>
				<a href="https://github.com/mythrantic/svelte-rich-text">GitHub</a>
				<a href="https://github.com/mythrantic/svelte-rich-text/issues">Report Issues</a>
			</div>
		</div>
	</footer>
</div>

<style>
	.landing {
		min-height: 100vh;
		background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%);
	}

	/* Hero Section */
	.hero {
		padding: 6rem 2rem;
		text-align: center;
		color: white;
	}

	.hero-content {
		max-width: 800px;
		margin: 0 auto;
	}

	.hero-title {
		font-size: clamp(2.5rem, 5vw, 4rem);
		font-weight: 800;
		margin-bottom: 1.5rem;
		line-height: 1.2;
		text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
	}

	.hero-subtitle {
		font-size: clamp(1.125rem, 2vw, 1.5rem);
		margin-bottom: 2.5rem;
		opacity: 0.95;
		line-height: 1.6;
	}

	.hero-buttons {
		display: flex;
		gap: 1rem;
		justify-content: center;
		flex-wrap: wrap;
	}

	.btn {
		padding: 1rem 2rem;
		border-radius: 0.5rem;
		font-weight: 600;
		text-decoration: none;
		transition: all 0.3s ease;
		display: inline-block;
		font-size: 1.125rem;
	}

	.btn-primary {
		background: #fbbf24;
		color: #7c2d12;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
		font-weight: 700;
	}

	.btn-primary:hover {
		background: #fcd34d;
		transform: translateY(-2px);
		box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
	}

	.btn-secondary {
		background: rgba(251, 191, 36, 0.2);
		color: #fef3c7;
		border: 2px solid #fbbf24;
		backdrop-filter: blur(10px);
	}

	.btn-secondary:hover {
		background: rgba(251, 191, 36, 0.3);
		border-color: #fcd34d;
		transform: translateY(-2px);
	}

	/* Features Section */
	.features {
		padding: 6rem 2rem;
		background: white;
	}

	.section-title {
		text-align: center;
		font-size: clamp(2rem, 4vw, 3rem);
		font-weight: 700;
		margin-bottom: 3rem;
		color: #2d3748;
	}

	.features-grid {
		max-width: 1200px;
		margin: 0 auto;
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		gap: 2rem;
	}

	.feature-card {
		padding: 2rem;
		background: linear-gradient(135deg, #fef3c7 0%, #ffffff 100%);
		border-radius: 1rem;
		border: 2px solid #fbbf24;
		box-shadow: 0 4px 6px rgba(220, 38, 38, 0.1);
		transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
	}

	.feature-card:hover {
		transform: translateY(-5px);
		box-shadow: 0 10px 20px rgba(220, 38, 38, 0.2);
		border-color: #dc2626;
	}

	.feature-card h3 {
		font-size: 1.5rem;
		font-weight: 700;
		margin-bottom: 0.75rem;
		color: #dc2626;
	}

	.feature-card p {
		color: #718096;
		line-height: 1.6;
	}

	/* Demo Section */
	.demo {
		padding: 6rem 2rem;
		background: linear-gradient(135deg, #f6f8fb 0%, #e9ecef 100%);
	}

	.demo-subtitle {
		text-align: center;
		font-size: 1.25rem;
		color: #718096;
		margin-bottom: 3rem;
	}

	.demo-container {
		max-width: 1400px;
		margin: 0 auto;
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
		gap: 2rem;
	}

	.demo-editor,
	.demo-preview {
		background: white;
		border-radius: 1rem;
		padding: 2rem;
		box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	}

	.demo-editor h3,
	.demo-preview h3 {
		font-size: 1.5rem;
		font-weight: 600;
		margin-bottom: 1.5rem;
		color: #2d3748;
	}

	.editor-wrapper,
	.preview-wrapper {
		border: 1px solid #e2e8f0;
		border-radius: 0.5rem;
		min-height: 400px;
		padding: 1rem;
		overflow-y: auto;
		max-height: 600px;
	}

	/* CTA Section */
	.cta {
		padding: 6rem 2rem;
		background: linear-gradient(135deg, #dc2626 0%, #7c2d12 100%);
		color: white;
		text-align: center;
	}

	.cta-content {
		max-width: 700px;
		margin: 0 auto;
	}

	.cta h2 {
		font-size: clamp(2rem, 4vw, 3rem);
		font-weight: 700;
		margin-bottom: 1rem;
	}

	.cta p {
		font-size: 1.25rem;
		margin-bottom: 2rem;
		opacity: 0.95;
	}

	.code-block {
		background: rgba(0, 0, 0, 0.3);
		padding: 1.5rem;
		border-radius: 0.5rem;
		margin: 2rem 0;
		border: 2px solid #fbbf24;
		font-family: 'Monaco', 'Courier New', monospace;
	}

	.code-block code {
		color: #fcd34d;
		font-size: 1.125rem;
	}

	.btn-large {
		padding: 1.25rem 3rem;
		font-size: 1.25rem;
	}

	/* Footer */
	.footer {
		padding: 3rem 2rem;
		background: #1c1917;
		color: white;
		text-align: center;
	}

	.footer-content {
		max-width: 1200px;
		margin: 0 auto;
	}

	.footer p {
		margin-bottom: 1rem;
		opacity: 0.9;
	}

	.footer a {
		color: #fbbf24;
		text-decoration: none;
		transition: color 0.3s ease;
	}

	.footer a:hover {
		color: #fcd34d;
	}

	.footer-links {
		display: flex;
		gap: 2rem;
		justify-content: center;
		flex-wrap: wrap;
	}

	.footer-links a {
		opacity: 0.8;
	}

	.footer-links a:hover {
		opacity: 1;
	}

	/* Responsive */
	@media screen and (max-width: 768px) {
		.hero {
			padding: 4rem 1.5rem;
		}

		.features,
		.demo,
		.cta {
			padding: 4rem 1.5rem;
		}

		.demo-container {
			grid-template-columns: 1fr;
		}

		.features-grid {
			grid-template-columns: 1fr;
		}

		.hero-buttons {
			flex-direction: column;
		}

		.btn {
			width: 100%;
		}
	}
</style>
