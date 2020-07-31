import { LIST_TIMERS } from "../graphql/timerQueries";

export const updateApolloCache = (cache, data) => {
  return cache.writeQuery({
    query: LIST_TIMERS,
    data: {
      timers: [
        ...cache.readQuery({ query: LIST_TIMERS })!.timers,
        data!.createTimer,
      ],
    },
  });
};
