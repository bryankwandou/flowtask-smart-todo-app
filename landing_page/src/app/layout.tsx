import type { Metadata } from "next";
import { Outfit } from "next/font/google";
import "./globals.css";

const outfit = Outfit({
  subsets: ["latin"],
  variable: "--font-outfit",
});

export const metadata: Metadata = {
  title: "FlowTask | Turn Daily Chaos into Focused Progress",
  description: "The modern productivity-focused To-Do application built with behavioral intelligence. Stay focused, track patterns, and master your workflow.",
  keywords: ["productivity", "task manager", "focus timer", "pomodoro", "analytics", "flow list"],
  authors: [{ name: "FlowTask Team" }],
  openGraph: {
    title: "FlowTask | Focused Progress",
    description: "Personal productivity intelligence tool for students, freelancers, and remote workers.",
    url: "https://flowtask-smart-todo-app.vercel.app",
    siteName: "FlowTask",
    images: [
      {
        url: "/og-image.png",
        width: 1200,
        height: 630,
      },
    ],
    locale: "en_US",
    type: "website",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="en"
      className={`${outfit.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">{children}</body>
    </html>
  );
}
