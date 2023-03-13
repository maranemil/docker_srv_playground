import * as React from 'react'
import Layout from '../components/layout'

const AboutPage = () => {
  return (
    <Layout pageTitle="About Me">
      <p>Hi there! I'm the proud creator of this site, which I built with Gatsby.</p>
      <div>
        <ul>
            <li>1. Lorem ipsum dolor sit amet, consectetur adipisici elit</li>
            <li>2. Lorem ipsum dolor sit amet, consectetur adipisici elit</li>
            <li>3. Lorem ipsum dolor sit amet, consectetur adipisici elit </li>
        </ul>
      </div>
    </Layout>

  )
}

export const Head = () => <title>About Me</title>

export default AboutPage
