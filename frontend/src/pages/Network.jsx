import React, { useState, useEffect, useRef, useCallback } from "react";
import ForceGraph2D from "react-force-graph-2d";
import { forceCollide } from "d3-force";
function Network() {
  const [graphData, setGraphData] = useState({ nodes: [], links: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [dataSize, setDataSize] = useState(1000);

  const fgRef = useRef();

  const API_URL = import.meta.env.VITE_API_BASE_URL || "";
  const fetchNetworkData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetch(
        `${API_URL}/api/network_data?limit=${dataSize}`
      );
      if (!response.ok) {
        throw new Error(`Failed to fetch network data: ${response.statusText}`);
      }
      const data = await response.json();
      setGraphData(data);
    } catch (err) {
      setError(err.message);
      console.error("Error fetching network data:", err);
    } finally {
      setLoading(false);
    }
  }, [dataSize]);

  useEffect(() => {
    fetchNetworkData();
  }, [fetchNetworkData]);

  const handleNodeClick = useCallback((node) => {
    const distance = 40;
    const nodeDistance = Math.hypot(node.x || 0, node.y || 0, node.z || 0);
    const distRatio = nodeDistance ? 1 + distance / nodeDistance : 1;

    if (fgRef.current) {
      fgRef.current.centerAt(
        (node.x || 0) * distRatio,
        (node.y || 0) * distRatio,
        1000
      );
      fgRef.current.zoom(2, 1000);
    }
  }, []);
  const nodeBaseSize = useCallback((node) => {
    // Centralize the base size calculation logic used for drawing AND collision
    const baseVal = node.val || 2;
    return Math.max(2, baseVal); // This is the size *before* scaling by nodeRelSize and globalScale
  }, []);

  const nodeCanvasObject = useCallback(
    (node, ctx, globalScale) => {
      const label = node.name || "Unknown";
      const fontSize = 12 / globalScale;
      ctx.font = `${fontSize}px Sans-Serif`;
      const visualRadius = (nodeBaseSize(node) * 1) / globalScale; // Assuming nodeRelSize=1

      const baseSize = node.val || 2;
      const size = Math.max(2, baseSize) / globalScale;

      ctx.beginPath();
      ctx.arc(node.x || 0, node.y || 0, visualRadius, 0, 2 * Math.PI, false);

      ctx.fillStyle = node.articleId ? "#4285F4" : node.color || "#666";
      ctx.fill();

      ctx.strokeStyle = "#FFF";
      ctx.lineWidth = 1.5 / globalScale;
      ctx.stroke();

      if (globalScale > 1.5) {
        const textWidth = ctx.measureText(label).width;
        const backgroundPadding = fontSize * 0.2;
        const backgroundWidth = textWidth + backgroundPadding * 2;
        const backgroundHeight = fontSize + backgroundPadding * 2;

        ctx.fillStyle = "rgba(255, 255, 255, 0.85)";
        ctx.fillRect(
          (node.x || 0) - backgroundWidth / 2,
          (node.y || 0) - size - backgroundHeight,
          backgroundWidth,
          backgroundHeight
        );

        ctx.textAlign = "center";
        ctx.textBaseline = "middle";
        ctx.fillStyle = "#333";
        ctx.fillText(
          label,
          node.x || 0,
          (node.y || 0) - size - backgroundHeight / 2
        );
      }
    },
    [nodeBaseSize]
  );

  const handleEngineStop = useCallback(() => {
    if (fgRef.current) {
      fgRef.current.zoomToFit(400, 50);
    }
  }, []);

  return (
    <div className="max-w-7xl mx-auto my-8 p-6 lg:p-10 bg-primary shadow-lg relative min-h-[80vh] overflow-hidden border-l-4 border-r-4 border-primary">
      <h1 className="text-4xl text-primary text-center mb-4 font-bold relative after:content-[''] after:absolute after:bottom-[-0.75rem] after:left-1/2 after:-translate-x-1/2 after:w-[100px] after:h-0.5 after:bg-primary">
        Historical Figure Network Visualization
      </h1>

      <div className="mb-6">
        <div className="flex justify-center items-center gap-4 mb-2">
          <label
            htmlFor="dataSize"
            className="text-sm font-medium text-gray-700"
          >
            Article count: {dataSize}
          </label>
          <input
            type="range"
            id="dataSize"
            min="50"
            max="3000"
            step="50"
            value={dataSize}
            onChange={(e) => setDataSize(Number(e.target.value))}
            className="w-64 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer dark:bg-gray-700"
            aria-label="Adjust number of articles"
          />
        </div>
      </div>

      {loading && (
        <div className="text-center py-8">
          <p className="text-lg text-gray-600">Loading network data...</p>
        </div>
      )}

      {error && (
        <div className="text-center py-8 text-red-600">
          <p className="text-lg font-semibold">Error loading data</p>
          <p className="text-sm">{error}</p>
        </div>
      )}

      {!loading && !error && (
        <div className="h-[70vh] w-full borderrounded shadow-inner bg-primary relative">
          {graphData.nodes && graphData.nodes.length > 0 ? (
            <ForceGraph2D
              ref={fgRef}
              width={1000}
              height={1000}
              graphData={graphData}
              nodeId="id"
              nodeVal="val"
              nodeLabel="name"
              nodeRelSize={1}
              nodeCanvasObject={nodeCanvasObject}
              nodeCanvasObjectMode={() => "after"}
              onNodeClick={handleNodeClick}
              linkColor={() => "#bbb"}
              linkWidth={0.5}
              linkDistance={150}
              d3Force={(simulation) => {
                simulation.force("charge").strength(-500);
                const padding = 2;
                simulation.force(
                  "collide",
                  forceCollide()
                    .radius((node) => nodeBaseSize(node) * 1.3 + padding)
                    .iterations(2) // Sometimes a second pass helps
                    .strength(1)
                );
              }}
              linkDirectionalParticles={1}
              linkDirectionalParticleWidth={1.5}
              linkDirectionalParticleSpeed={(d) => (d.value || 0.01) * 0.002}
              cooldownTicks={100}
              warmupTicks={50}
              onEngineStop={handleEngineStop}
              d3AlphaDecay={0.01}
              d3VelocityDecay={0.3}
            />
          ) : (
            <div className="absolute inset-0 flex items-center justify-center">
              <p className="text-xl text-gray-500">
                No network data available to display.
              </p>
            </div>
          )}
        </div>
      )}
      <footer className="text-center mt-12 py-6 text-secondary text-sm font-medium border-t-2 border-border bg-primary/[0.03] relative before:content-[''] before:absolute before:left-1/2 before:top-[-15px] before:-translate-x-1/2 before:w-[30px] before:h-[30px] before:bg-paper before:border-2 before:border-border before:rounded-full">
        <p>明清實錄 • Ming Qing Shilu</p>
      </footer>
    </div>
  );
}

export default Network;
