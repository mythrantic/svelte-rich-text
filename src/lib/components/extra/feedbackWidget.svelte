<script lang="ts">
	let feedback = '';

	function submit() {
		console.log('Feedback submitted:', feedback);
		alert('Feedback submitted!');
		feedback = '';
	}
</script>

<div class="feedback-widget">
	<h3>Feedback</h3>
	<textarea bind:value={feedback} placeholder="Your feedback here"></textarea>
	<button on:click={submit}>Send</button>
</div>

<style>
	.feedback-widget {
		position: fixed;
		bottom: 20px;
		right: 20px;
		width: 300px;
		padding: 10px;
		background: #fff;
		border: 1px solid #ccc;
		box-shadow: 0 2px 10px rgba(0,0,0,0.1);
	}

	textarea {
		width: 100%;
		height: 80px;
		margin-bottom: 10px;
	}

	button {
		width: 100%;
	}
</style>