//Packages
import React from 'react'
import styled from 'styled-components'

//Source Code
import AccordionsSection from './AccordionsSection';
import PersonalInfo from './PersonalInfo';

//Component
function ProfilePage(props) {

    return (
        <div>
            <BgColor>
                <TempoPadding>
                    <MarginBottom20>
                        <div className='card-border bg-white'>
                            <PersonalInfo />
                        </div>
                    </MarginBottom20>
                    <AccordionsSection />
                </TempoPadding>
            </BgColor>
        </div>
    );
}

//Styling
const BgColor = styled.div`
    background-color: #F5EAEA;
`;
const TempoPadding = styled.div`
    padding: 10vh 15vw;
`;
const MarginBottom20 = styled.div`
    margin-bottom: 3rem;
`;

export default ProfilePage;
