import Image from 'next/image'
import { Inter } from 'next/font/google'
import styles from './page.module.css'

const inter = Inter({ subsets: ['latin'] })

export default function About() {
  return (
      <main className={styles.main}>
        <ul style={{ 'list-style': 'none' }}>
            <li><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
        </ul>
     <h1>About, Next.js!</h1>
     </main>
  )
}