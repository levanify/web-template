import { useState } from "react";
import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import { Button } from "./components/ui/button";

import { ThemeProvider } from "@/components/themes/theme-provider";
import { ModeToggle } from "@/components/themes/mode-toggle";

function App() {
  const [count, setCount] = useState(0);

  return (
    <ThemeProvider defaultTheme="system" storageKey="vite-ui-theme">
      <div className="min-h-screen flex flex-col items-center justify-center p-8 gap-6 bg-background text-foreground">
        <div className="flex gap-6 items-center">
          <a
            href="https://vite.dev"
            target="_blank"
            className="hover:scale-110 transition-transform"
          >
            <img src={viteLogo} className="h-16 w-16" alt="Vite logo" />
          </a>
          <a
            href="https://react.dev"
            target="_blank"
            className="hover:scale-110 transition-transform"
          >
            <img src={reactLogo} className="h-16 w-16" alt="React logo" />
          </a>
        </div>
        <h1 className="text-4xl font-bold mb-4">Vite + React</h1>

        <div className="flex flex-col items-center gap-6">
          <ModeToggle />

          <Button className="px-6 py-2 text-lg">Click me</Button>

          <div className="flex flex-col items-center gap-3 bg-card rounded-lg p-6 shadow-md">
            <button
              onClick={() => setCount((count) => count + 1)}
              className="px-4 py-2 bg-primary text-primary-foreground rounded-md hover:bg-primary/90 transition-colors"
            >
              count is {count}
            </button>
            <p className="text-muted-foreground">
              Edit{" "}
              <code className="bg-muted px-1 py-0.5 rounded text-sm">
                src/App.tsx
              </code>{" "}
              and save to test HMR
            </p>
          </div>

          <p className="text-sm text-muted-foreground mt-4">
            Click on the Vite and React logos to learn more
          </p>
        </div>
      </div>
    </ThemeProvider>
  );
}

export default App;
