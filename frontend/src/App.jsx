import { Routes, Route, Navigate } from "react-router-dom";

import Header from "./components/Header";
import Home from "./pages/Home";
import Statistics from "./pages/Statistics";
import Network from "./pages/Network";
import Explorer from "./pages/Explorer";
import MyTable from "./pages/MyTable";
function App() {
  return (
    <div className="flex flex-col min-h-screen bg-background bg-[url('https://images.unsplash.com/photo-1598113256332-55c28a6c32ba?ixlib=rb-1.2.1&auto=format&fit=crop&w=2000&q=80')] bg-cover bg-center bg-fixed bg-blend-overlay relative before:content-[''] before:absolute before:inset-0 before:bg-background/90 before:-z-10">
      <Header />
      <div className="flex flex-1 pt-[70px]">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/home" element={<Navigate to="/" replace />} />
          <Route path="/explorer" element={<Explorer />} />
          <Route path="/statistics" element={<Statistics />} />
          <Route path="/network" element={<Network />} />
          <Route path="/mytable" element={<MyTable />} />
        </Routes>
      </div>
    </div>
  );
}

export default App;
