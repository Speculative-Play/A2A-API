import React from "react";

function Users(props) {
    return (
        <div>
            <h1>These Users are from the API</h1>
            {props.users.map((user) => {
                return (
                    <div key={user.id}>
                        <h2>{user.username}</h2>
                        <p>User id = {user.id}</p>
                    </div>
                );
            })}
        </div>
    );
}

export default Users;