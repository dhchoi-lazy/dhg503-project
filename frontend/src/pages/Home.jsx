import React from "react";
import { BookOpenText, Users, Search, BarChart, Network } from "lucide-react";

function Home() {
  return (
    <div className="relative bg-paper shadow-lg max-w-4xl mx-auto my-8 p-10 overflow-hidden border-l-4 border-r-4 border-primary before:content-[''] before:absolute before:top-0 before:left-0 before:right-0 before:h-5 before:bg-gradient-to-b before:from-primary/15 before:to-transparent after:content-[''] after:absolute after:bottom-0 after:left-0 after:right-0 after:h-5 after:bg-gradient-to-b after:from-transparent after:to-primary/15 after:rotate-180">
      <h1 className="text-4xl text-primary mb-8 text-center tracking-wide drop-shadow-sm relative after:content-[''] after:absolute after:bottom-[-0.75rem] after:left-1/2 after:-translate-x-1/2 after:w-[100px] after:h-0.5 after:bg-primary">
        Ming-Qing Shilu Digital Archive
      </h1>

      <div className="border-2 border-border relative overflow-hidden p-8 mb-8 before:content-[''] before:absolute before:top-0 before:left-0 before:right-0 before:h-1 before:bg-gradient-to-r before:from-red-seal before:to-primary">
        <p className="text-lg leading-8 text-justify mb-6 relative">
          Welcome to the Digital History Project of Digital Data Management in
          Asia Studies, DHGA Lingnan University. This website features over
          160,000 historical records from the Ming and Qing dynasties, spanning
          276 years of Chinese history, with data sourced from the{" "}
          <a
            href="https://sillok.history.go.kr/mc/main.do"
            className="text-primary underline font-medium hover:text-secondary transition-colors duration-300"
          >
            Veritable Records of the Ming and Veritable Records of the Qing
          </a>
          .
        </p>
        <p className="text-lg leading-8 text-justify">
          The "Shilu" are historical records compiled by official historians
          documenting the words and actions of emperors, serving as primary
          sources for studying Chinese history. These records detail historical
          events, political systems, economic developments, cultural evolution,
          and social changes from 1368 to 1912, providing invaluable insights
          into China's imperial past.
        </p>
      </div>

      <div className="space-y-6">
        <div className="border-2 border-border relative overflow-hidden p-6 before:content-[''] before:absolute before:top-0 before:left-0 before:right-0 before:h-1 before:bg-gradient-to-r before:from-red-seal before:to-primary">
          <h2 className="flex items-center mb-4 text-primary text-xl font-bold">
            <BookOpenText size={24} className="mr-2" />
            <span>Browse Historical Articles</span>
          </h2>
          <p className="text-lg leading-8">
            Explore our extensive collection of historical records with our
            powerful article browser. Search through documents using keywords,
            navigate through different time periods, and examine detailed
            content of original texts from emperors across multiple dynasties.
          </p>
        </div>
        <div className="border-2 border-border relative overflow-hidden p-6 before:content-[''] before:absolute before:top-0 before:left-0 before:right-0 before:h-1 before:bg-gradient-to-r before:from-red-seal before:to-primary">
          <h2 className="flex items-center mb-4 text-primary text-xl font-bold">
            <Network size={24} className="mr-2" />
            <span>Historical Figure Network Visualization</span>
          </h2>
          <p className="text-lg leading-8">
            Discover connections between historical figures with our interactive
            network visualization tool. Explore relationships between characters
            mentioned in the records, adjust the data size to focus on specific
            time periods, and gain insights into the complex social and
            political networks of imperial China.
          </p>
        </div>

        <div className="border-2 border-border relative overflow-hidden p-6 before:content-[''] before:absolute before:top-0 before:left-0 before:right-0 before:h-1 before:bg-gradient-to-r before:from-red-seal before:to-primary">
          <h2 className="flex items-center mb-4 text-primary text-xl font-bold">
            <BarChart size={24} className="mr-2" />
            <span>Statistical Analysis</span>
          </h2>
          <p className="text-lg leading-8">
            Analyze historical data through various visualizations including
            distribution by king, chronological trends, and comparative metrics.
            Our statistics tools provide insights into the composition of the
            archive, highlighting patterns across different rulers and time
            periods through interactive charts and graphs.
          </p>
        </div>
      </div>
      <footer className="text-center mt-12 py-6 text-secondary text-sm font-medium border-t-2 border-border bg-primary/[0.03] relative before:content-[''] before:absolute before:left-1/2 before:top-[-15px] before:-translate-x-1/2 before:w-[30px] before:h-[30px] before:bg-paper before:border-2 before:border-border before:rounded-full">
        <p>明清實錄 • Ming Qing Shilu</p>
      </footer>
    </div>
  );
}

export default Home;
