import React, { useState, useEffect } from "react";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  PointElement,
  LineElement,
  RadialLinearScale,
  Filler,
} from "chart.js";
import { Bar, Doughnut, Line, Radar } from "react-chartjs-2";
import {
  Loader2,
  AlertTriangle,
  BarChart3,
  PieChart,
  TrendingUp,
} from "lucide-react";

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  PointElement,
  LineElement,
  RadialLinearScale,
  Filler
);

const THEME_COLORS = {
  primary: {
    light: "rgba(59, 130, 246, 0.1)",
    medium: "rgba(59, 130, 246, 0.5)",
    main: "rgba(59, 130, 246, 0.8)",
    dark: "rgba(59, 130, 246, 1)",
  },
  secondary: {
    light: "rgba(139, 92, 246, 0.1)",
    medium: "rgba(139, 92, 246, 0.5)",
    main: "rgba(139, 92, 246, 0.8)",
    dark: "rgba(139, 92, 246, 1)",
  },
  accent: {
    light: "rgba(16, 185, 129, 0.1)",
    medium: "rgba(16, 185, 129, 0.5)",
    main: "rgba(16, 185, 129, 0.8)",
    dark: "rgba(16, 185, 129, 1)",
  },
  neutral: {
    bg: "rgba(249, 250, 251, 1)",
    card: "rgba(255, 255, 255, 1)",
    text: "rgba(31, 41, 55, 1)",
    textLight: "rgba(107, 114, 128, 1)",
  },
};

// Chart color sets for consistent visualization
const CHART_COLORS = [
  THEME_COLORS.primary.main,
  THEME_COLORS.secondary.main,
  THEME_COLORS.accent.main,
  THEME_COLORS.primary.dark,
  THEME_COLORS.secondary.dark,
];

const CHART_BORDER_COLORS = [
  THEME_COLORS.primary.dark,
  THEME_COLORS.secondary.dark,
  THEME_COLORS.accent.dark,
  THEME_COLORS.primary.dark,
  THEME_COLORS.secondary.dark,
];

// Generate gradient for charts
const getGradient = (ctx, color) => {
  if (!ctx) return color;

  const gradient = ctx.createLinearGradient(0, 0, 0, 400);
  gradient.addColorStop(0, color);
  gradient.addColorStop(1, "rgba(255, 255, 255, 0.1)");
  return gradient;
};

function Statistics() {
  const [statisticsData, setStatisticsData] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const API_URL = import.meta.env.VITE_API_BASE_URL || "";

  useEffect(() => {
    const fetchStatistics = async () => {
      setIsLoading(true);
      setError(null);
      try {
        const response = await fetch(`${API_URL}/api/statistics`);
        if (!response.ok) {
          throw new Error(`Server returned ${response.status}`);
        }
        const data = await response.json();
        setStatisticsData(data);
      } catch (error) {
        console.error("Error fetching statistics:", error);
        setError(`Failed to load statistics: ${error.message}`);
      } finally {
        setIsLoading(false);
      }
    };
    fetchStatistics();
  }, []);

  const sharedOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: "top",
        labels: {
          font: {
            family: "'Inter', sans-serif",
            size: 12,
          },
          usePointStyle: true,
          padding: 20,
        },
      },
      tooltip: {
        backgroundColor: "rgba(0, 0, 0, 0.75)",
        titleFont: {
          family: "'Inter', sans-serif",
          size: 14,
          weight: "bold",
        },
        bodyFont: {
          family: "'Inter', sans-serif",
          size: 13,
        },
        padding: 12,
        cornerRadius: 8,
        displayColors: true,
      },
    },
    animation: {
      duration: 1500,
      easing: "easeOutQuart",
    },
  };

  // Bar chart options
  const barOptions = {
    ...sharedOptions,
    scales: {
      y: {
        beginAtZero: true,
        grid: {
          display: true,
          color: "rgba(0, 0, 0, 0.05)",
        },
        ticks: {
          font: {
            family: "'Inter', sans-serif",
            size: 12,
          },
        },
      },
      x: {
        grid: {
          display: false,
        },
        ticks: {
          font: {
            family: "'Inter', sans-serif",
            size: 12,
          },
        },
      },
    },
  };

  // Line chart options
  const lineOptions = {
    ...sharedOptions,
    scales: {
      y: {
        beginAtZero: true,
        grid: {
          color: "rgba(0, 0, 0, 0.05)",
        },
        ticks: {
          font: {
            family: "'Inter', sans-serif",
            size: 12,
          },
        },
      },
      x: {
        grid: {
          display: false,
        },
        ticks: {
          font: {
            family: "'Inter', sans-serif",
            size: 12,
          },
        },
      },
    },
    elements: {
      line: {
        tension: 0.4,
      },
      point: {
        radius: 4,
        hoverRadius: 6,
      },
    },
  };

  // Doughnut chart options
  const doughnutOptions = {
    ...sharedOptions,
    cutout: "70%",
    plugins: {
      ...sharedOptions.plugins,
      legend: {
        ...sharedOptions.plugins.legend,
        position: "right",
      },
    },
  };

  // Radar chart options
  const radarOptions = {
    ...sharedOptions,
    scales: {
      r: {
        beginAtZero: true,
        ticks: {
          backdropColor: "transparent",
          showLabelBackdrop: false,
        },
        pointLabels: {
          font: {
            family: "'Inter', sans-serif",
            size: 12,
          },
        },
        grid: {
          color: "rgba(0, 0, 0, 0.1)",
        },
        angleLines: {
          color: "rgba(0, 0, 0, 0.1)",
        },
      },
    },
    elements: {
      line: {
        borderWidth: 2,
      },
    },
  };

  // Prepare chart data
  const prepareChartData = () => {
    if (!statisticsData) return null;

    // Sort year data chronologically
    const sortedYearData = [...statisticsData.cnt_by_year].sort(
      (a, b) => parseInt(a.year) - parseInt(b.year)
    );

    // Store the sorted data for use in the component
    const firstYear =
      sortedYearData.length > 0 ? sortedYearData[0].year : "N/A";
    const lastYear =
      sortedYearData.length > 0
        ? sortedYearData[sortedYearData.length - 1].year
        : "N/A";

    const kingData = {
      labels: statisticsData.cnt_by_king.map((item) => item.king),
      datasets: [
        {
          label: "Articles by King",
          data: statisticsData.cnt_by_king.map((item) => item.count),
          backgroundColor: (context) =>
            getGradient(context.chart.ctx, THEME_COLORS.primary.main),
          borderColor: THEME_COLORS.primary.dark,
          borderWidth: 1,
          borderRadius: 8,
          hoverOffset: 4,
        },
      ],
    };

    const yearData = {
      labels: sortedYearData.map((item) => item.year),
      datasets: [
        {
          label: "Articles by Year",
          data: sortedYearData.map((item) => item.count),
          backgroundColor: THEME_COLORS.secondary.medium,
          borderColor: THEME_COLORS.secondary.dark,
          borderWidth: 1,
          fill: true,
          tension: 0.4,
        },
      ],
    };

    const doughnutData = {
      labels: statisticsData.cnt_by_king.map((item) => item.king),
      datasets: [
        {
          label: "Articles by King",
          data: statisticsData.cnt_by_king.map((item) => item.count),
          backgroundColor: CHART_COLORS,
          borderColor: CHART_BORDER_COLORS,
          borderWidth: 1,
          hoverOffset: 10,
        },
      ],
    };

    // Radar chart for comparing kings by percentage of total
    const total = statisticsData.total;
    const radarData = {
      labels: statisticsData.cnt_by_king.map((item) => item.king),
      datasets: [
        {
          label: "Percentage of Total Articles",
          data: statisticsData.cnt_by_king.map((item) =>
            ((item.count / total) * 100).toFixed(1)
          ),
          backgroundColor: "rgba(139, 92, 246, 0.2)",
          borderColor: THEME_COLORS.secondary.dark,
          borderWidth: 2,
          pointBackgroundColor: THEME_COLORS.secondary.dark,
          pointBorderColor: "#fff",
          pointHoverBackgroundColor: "#fff",
          pointHoverBorderColor: THEME_COLORS.secondary.dark,
        },
      ],
    };

    return { kingData, yearData, doughnutData, radarData, firstYear, lastYear };
  };

  const chartData = prepareChartData();

  // Common card styling
  const cardStyle = "bg-primary rounded-lg shadow-md p-5";
  const chartContainerStyle = "h-80 md:h-96";
  const titleStyle = "text-lg font-semibold text-gray-800 mb-4";

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center p-4 mx-auto">
        <div className="rounded-lg shadow-md p-8 w-full max-w-md text-center">
          <Loader2 className="h-12 w-12 animate-spin text-blue-500 mx-auto mb-4" />
          <h2 className="text-2xl font-bold text-gray-800 mb-2">
            Loading Statistics
          </h2>
          <p className="text-gray-600">
            Gathering the latest data for visualization...
          </p>
        </div>
      </div>
    );
  }

  if (error && !statisticsData) {
    return (
      <div className="min-h-screen flex items-center justify-center p-4">
        <div className="bg-white rounded-lg shadow-md p-8 w-full max-w-md text-center">
          <AlertTriangle className="h-12 w-12 text-red-500 mx-auto mb-4" />
          <h2 className="text-2xl font-bold text-gray-800 mb-2">
            Error Loading Data
          </h2>
          <p className="text-red-600 mb-4">{error}</p>
          <p className="text-gray-600">
            Please check your connection and try again later.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen p-4 md:p-6 bg-background mx-auto w-full">
      {chartData && (
        <div className="max-w-7xl mx-auto">
          {/* Summary Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-5 mb-5">
            <div className={`${cardStyle} flex items-center`}>
              <div className="p-3 bg-blue-100 rounded-lg mr-4">
                <BarChart3 className="h-8 w-8 text-blue-600" />
              </div>
              <div>
                <h3 className="text-sm font-semibold text-gray-600 uppercase tracking-wider">
                  Total Articles
                </h3>
                <p className="text-2xl font-bold text-gray-800">
                  {statisticsData.total}
                </p>
              </div>
            </div>

            <div className={`${cardStyle} flex items-center`}>
              <div className="p-3 bg-blue-100 rounded-lg mr-4">
                <PieChart className="h-8 w-8 text-blue-600" />
              </div>
              <div>
                <h3 className="text-sm font-semibold text-gray-600 uppercase tracking-wider">
                  Different Kings
                </h3>
                <p className="text-2xl font-bold text-gray-800">
                  {statisticsData.cnt_by_king.length}
                </p>
              </div>
            </div>

            <div className={`${cardStyle} flex items-center`}>
              <div className="p-3 bg-blue-100 rounded-lg mr-4">
                <TrendingUp className="h-8 w-8 text-blue-600" />
              </div>
              <div>
                <h3 className="text-sm font-semibold text-gray-600 uppercase tracking-wider">
                  Time Period
                </h3>
                <p className="text-2xl font-bold text-gray-800">
                  {chartData.firstYear} - {chartData.lastYear}
                </p>
              </div>
            </div>
          </div>

          {/* Chart Grid */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-5 mb-5">
            <div className={cardStyle}>
              <h2 className={titleStyle}>Articles by King</h2>
              <div className={chartContainerStyle}>
                <Bar options={barOptions} data={chartData.kingData} />
              </div>
            </div>
            <div className={cardStyle}>
              <h2 className={titleStyle}>Articles by Year</h2>
              <div className={chartContainerStyle}>
                <Line options={lineOptions} data={chartData.yearData} />
              </div>
            </div>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
            <div className={cardStyle}>
              <h2 className={titleStyle}>Distribution by King</h2>
              <div className={chartContainerStyle}>
                <Doughnut
                  options={doughnutOptions}
                  data={chartData.doughnutData}
                />
              </div>
            </div>
            <div className={cardStyle}>
              <h2 className={titleStyle}>Relative Contribution (%)</h2>
              <div className={chartContainerStyle}>
                <Radar options={radarOptions} data={chartData.radarData} />
              </div>
            </div>
          </div>
        </div>
      )}
      <footer className="text-center mt-12 py-6 text-secondary text-sm font-medium border-t-2 border-border bg-primary/[0.03] relative before:content-[''] before:absolute before:left-1/2 before:top-[-15px] before:-translate-x-1/2 before:w-[30px] before:h-[30px] before:bg-paper before:border-2 before:border-border before:rounded-full">
        <p>明清實錄 • Ming Qing Shilu</p>
      </footer>
    </div>
  );
}

export default Statistics;
