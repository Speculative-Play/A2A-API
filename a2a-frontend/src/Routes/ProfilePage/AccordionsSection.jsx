//Packages
import React from 'react'
import styled from 'styled-components'

//Source code
import AccordionItem from './AccordionItem';

//Component
function AccordionsSection(props) {

    return (
        <div>
                <AccordionItem progressColor="#8777D9" />
                <AccordionItem progressColor="#FFC400" />
                <AccordionItem progressColor="#57D9A3" />
                <AccordionItem progressColor="#FF7452" />
        </div>
    );
}

//Styling
const TempoPadding = styled.div`
    padding: 10vh 20vw;
`;

export default AccordionsSection;
