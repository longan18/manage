import type { Metadata } from "next";
import localFont from "next/font/local";
import "./globals.css";

// Font files can be colocated inside of `app`
const myFont = localFont({
  src: [
    {
      path: "./Roboto-Thin.ttf",
      weight: "100",
      style: "normal",
    },
    {
      path: "./Roboto-Regular.ttf",
      weight: "400",
      style: "normal",
    },
  ],
  display: "swap",
  variable: "--font-roboto",
});

export const metadata: Metadata = {
  title: "Management System",
  description: "Management System",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${myFont.className}`}>{children}</body>
    </html>
  );
}
