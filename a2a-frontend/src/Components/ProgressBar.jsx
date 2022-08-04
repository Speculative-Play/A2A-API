import React from "react";

const ProgressBar = (props) => {
    const bgcolor = '#E8A3B0';
    
    const containerStyles = {
      height: 5,
      width: '75%',
      backgroundColor: "#D9D9D9",
      borderRadius: 50,
      margin: 50
    }
  
    const fillerStyles = {
      height: '75%',
      width: `${props.completed}%`,
      backgroundColor: bgcolor,
      borderRadius: 'inherit',
      textAlign: 'right', 
      transition: 'width 1s ease-in-out'
    }
  
    const labelStyles = {
      padding: 5,
      color: 'white',
      fontWeight: 'bold'
    }
  
    return (
      <div style={containerStyles}>
        <div style={fillerStyles}>
        </div>
      </div>
    );
  };

export default ProgressBar;