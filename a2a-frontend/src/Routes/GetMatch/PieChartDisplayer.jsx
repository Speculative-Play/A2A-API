//Packages
import React, {useState } from 'react'
import { useEffect, useRef } from "react";

//Component
export default () => {
    const SearchMap = useRef(); // optional, but useful if the Map object is used after mounting
    const [v1, setV1] = useState(40)
    const [v2, setV2] = useState(30)
    const [v3, setV3] = useState(20)
    const [v4, setV4] = useState(10)


    const callChange = (piechart) => {
        console.log('call change')
        let newSizes = piechart.getAllSliceSizePercentages()
        setV1(newSizes[0].toFixed(0))
        setV2(newSizes[1].toFixed(0))
        setV3(newSizes[2].toFixed(0))
        setV4(newSizes[3].toFixed(0))

            var percentages = piechart.getAllSliceSizePercentages();

            var btnCnt = document.getElementById('categories-container')

            var cntTemp = ''
            for(var i = 0; i < proportions.length; i += 1) {
                var categoryName = '<div>' + proportions[i].format.name + '</div>';
                var plus = ''
                var remove = ''
                if(percentages[i].toFixed(0) < 1){
                    plus = '<i class="material-icons adjust-button" data-i="' + i + '" data-d="-1">add</i>';
                }
                else{
                    remove = '<i class="material-icons adjust-button" data-i="' + i + '" data-d="1">remove</i>';
                }
                var parentDiv = '<div class="category-card ' +proportions[i].format.shortName +'">' + categoryName + plus + remove + '</div>'
                cntTemp += parentDiv
            }
            btnCnt.innerHTML = cntTemp

            
            function adjustClick(e) {
                var i = this.getAttribute('data-i');
                var d = this.getAttribute('data-d');
                piechart.moveAngle(i, (d * 0.1));
            }

            var adjust = document.getElementsByClassName("adjust-button");

            for (i = 0; i < adjust.length; i++) {
                adjust[i].addEventListener('click', adjustClick);
            }
    }

    const [proportions,setProportions] = useState([
        { proportion: v1, format: { color: "#FFF0B3", shortName:"ethnicity" ,label: 'E,R',name: 'Ethnicity, Religion' } },
        { proportion: v2, format: { color: "#B3D4FF", shortName:"habits" ,label: 'L,H',name: 'Lifestyle, Habits' } },
        { proportion: v3, format: { color: "#ABF5D1", shortName:"hobbies" ,label: 'H',name: 'Hobbies' } },
        { proportion: v4, format: { color: "#FFBDAD", shortName:"physical" ,label: 'PC',name: 'Physical Characteristics' } }
    ]);

    useEffect(() => {
        //console.log('useeffect')
        const scriptTag = document.createElement("script");
        scriptTag.src = "draggable-pie-chart.js";
        document.body.appendChild(scriptTag);

        scriptTag.onload = () => {
            SearchMap.current = new window.DraggablePiechart({
                canvas: document.getElementById('piechart'),
                proportions: proportions,
                radius: .8,
                collapsing: true,
                minAngle: 0.1,
                onchange: callChange,
            });
        };

    }, [SearchMap]);

    return (
        <>
            <canvas id="piechart" width="500" height="500">Your browser is too old!</canvas>

            <div style={{display:'flex',gap:'40px'}}>
                <h4>{Math.round(v1)}</h4>
                <h4>{Math.round(v2)}</h4>
                <h4>{Math.round(v3)}</h4>
                <h4>{Math.round(v4)}</h4>
            </div>

        </>

    );
};