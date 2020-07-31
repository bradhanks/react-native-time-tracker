// import { gql } from "@apollo/client";
// import { WebSocketLink } from "@apollo/client/link/ws";

// const wsLink = new WebSocketLink({
//   uri: `ws://localhost:4000/`,
//   options: {
//     reconnect: true,
//   },
// });

// export const GET_CLOCK = gql`
//   subscription GetClockTime($id: ID!) {
//     clock(timer_id: $id) {
//       id
//       isRunning
//       elapsed
//     }
//   }
// `;
