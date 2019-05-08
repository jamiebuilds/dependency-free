import React, { useState } from "react"
import { css } from "emotion"

export function App() {
	let [count, setCount] = useState(0)

	let decrement = () => setCount(count - 1)
	let increment = () => setCount(count + 1)

	return (
		<div className={styles.container}>
			<h1>My Cool App</h1>
			<button className={styles.button} onClick={decrement}>
				-
			</button>
			<span className={styles.count}>{count}</span>
			<button className={styles.button} onClick={increment}>
				+
			</button>
		</div>
	)
}

let styles = {
	container: css`
		text-align: center;
		font-size: 2em;
	`,
	button: css`
		font: inherit;
		border: none;
		background: #36c;
		color: white;
		padding: 0.5em 1em;
	`,
	count: css`
		padding: 0.5em 1em;
	`,
}
