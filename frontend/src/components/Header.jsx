import React from "react";
import { NavLink } from "react-router-dom";

function Header() {
  return (
    // Changed bg-paper to bg-white
    <header className="fixed top-0 left-0 right-0 z-50 flex justify-between items-center px-6 py-3 bg-primary border-b-2 border-primary shadow-md h-[70px]">
      <div className="text-2xl font-bold text-primary flex items-center gap-2">
        <NavLink to={"/"}>明清實錄</NavLink>
      </div>
      <nav>
        <ul className="flex">
          <li className="ml-6">
            <NavLink
              to="/"
              end // Added 'end' prop for more accurate active state matching on the root path
              className={({ isActive }) =>
                `text-secondary font-medium transition-all duration-300 px-2 py-2 relative hover:text-primary
                 ${
                   isActive
                     ? "text-primary after:absolute after:bottom-[-3px] after:left-0 after:w-full after:h-0.5 after:bg-primary"
                     : "after:absolute after:bottom-[-3px] after:left-0 after:w-0 after:h-0.5 after:bg-primary after:transition-width after:duration-300 hover:after:w-full"
                 }`
              }
            >
              Home
            </NavLink>
          </li>
          <li className="ml-6">
            <NavLink
              to="/explorer"
              className={({ isActive }) =>
                `text-secondary font-medium transition-all duration-300 px-2 py-2 relative hover:text-primary
                 ${
                   isActive
                     ? "text-primary after:absolute after:bottom-[-3px] after:left-0 after:w-full after:h-0.5 after:bg-primary"
                     : "after:absolute after:bottom-[-3px] after:left-0 after:w-0 after:h-0.5 after:bg-primary after:transition-width after:duration-300 hover:after:w-full"
                 }`
              }
            >
              Explorer
            </NavLink>
          </li>
          <li className="ml-6">
            <NavLink
              to="/statistics"
              className={({ isActive }) =>
                `text-secondary font-medium transition-all duration-300 px-2 py-2 relative hover:text-primary
                 ${
                   isActive
                     ? "text-primary after:absolute after:bottom-[-3px] after:left-0 after:w-full after:h-0.5 after:bg-primary"
                     : "after:absolute after:bottom-[-3px] after:left-0 after:w-0 after:h-0.5 after:bg-primary after:transition-width after:duration-300 hover:after:w-full"
                 }`
              }
            >
              Statistics
            </NavLink>
          </li>
          <li className="ml-6">
            <NavLink
              to="/network"
              className={({ isActive }) =>
                `text-secondary font-medium transition-all duration-300 px-2 py-2 relative hover:text-primary
                 ${
                   isActive
                     ? "text-primary after:absolute after:bottom-[-3px] after:left-0 after:w-full after:h-0.5 after:bg-primary"
                     : "after:absolute after:bottom-[-3px] after:left-0 after:w-0 after:h-0.5 after:bg-primary after:transition-width after:duration-300 hover:after:w-full"
                 }`
              }
            >
              Network
            </NavLink>
          </li>
          <li className="ml-6">
            <NavLink
              to="/mytable"
              className={({ isActive }) =>
                `text-secondary font-medium transition-all duration-300 px-2 py-2 relative hover:text-primary
                 ${
                   isActive
                     ? "text-primary after:absolute after:bottom-[-3px] after:left-0 after:w-full after:h-0.5 after:bg-primary"
                     : "after:absolute after:bottom-[-3px] after:left-0 after:w-0 after:h-0.5 after:bg-primary after:transition-width after:duration-300 hover:after:w-full"
                 }`
              }
            >
              My Table
            </NavLink>
          </li>
        </ul>
      </nav>
    </header>
  );
}

export default Header;
