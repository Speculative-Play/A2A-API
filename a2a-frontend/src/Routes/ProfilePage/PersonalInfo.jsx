//Packages
import React from "react";
import { Button, Grid } from '@material-ui/core';


//Component
function PersonalInfo(props) {

    const sampleOption = <>
        <Grid item xs={6} sm={4} md={4} className="txt-left ">
            <div className="grey-txt profile-option-label txt-size-regular">
                Gender:
            </div>
            <div className="dark-grey-txt semi-bold txt-size-regular">
                Female
            </div>
        </Grid>
    </>

    return <div className="personal-info">
        <div>
            <div>
                <h4 className="user-title"> Personal Information </h4>
            </div>
            <div>
                <Grid container >
                    <Grid item xs={12} sm={4} md={3}>
                        <div className="left-side-padding">
                            <div>
                                <img className="full-width profile-image" src="/images/sample_user_female.jpeg" alt="sample user" />
                            </div>
                            <div>
                                <h3 className="profile-name">Idika Laghari</h3>
                            </div>
                            <div>
                                <Button className="edit-profile-button">Edit profile</Button>
                            </div>
                        </div>
                    </Grid>
                    <Grid item xs={12} sm={8} md={9}>
                        <Grid container spacing={6} justifyContent='flex-start'>
                            {sampleOption}
                            {sampleOption}
                            {sampleOption}
                            {sampleOption}
                            {sampleOption}
                            {sampleOption}
                            {sampleOption}
                            {sampleOption}

                        </Grid>
                    </Grid>
                </Grid>
            </div>
        </div>
    </div>;
}

export default PersonalInfo;