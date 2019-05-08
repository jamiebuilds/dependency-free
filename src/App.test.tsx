import React from "react"
import { App } from "./App"
import { render, fireEvent } from "react-testing-library"
import "jest-dom/extend-expect"

test("it works", () => {
	let { getByText } = render(<App />)
	expect(getByText("0")).toBeInTheDocument()
	fireEvent.click(getByText("+"))
	expect(getByText("1")).toBeInTheDocument()
	fireEvent.click(getByText("-"))
	expect(getByText("0")).toBeInTheDocument()
})
