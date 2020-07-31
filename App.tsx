import { useQuery } from "@apollo/client";
import React, { useState } from "react";
import {
  KeyboardAvoidingView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  View,
} from "react-native";
import EditableTimer from "./components/EditableTimer";
import ToggleableTimerForm from "./components/ToggleableTimerForm";
import { LIST_TIMERS } from "./graphql/timerQueries";

export const App = () => {
  const [matching, setMatching] = useState(undefined);
  const [status, setStatus] = useState(undefined);
  const [elapsed, setElapsed] = useState(undefined);

  //const [status, setStatus] = useState("");

  const { loading, data, error } = useQuery(LIST_TIMERS, {
    variables: { matching, elapsed, status },
  });

  //Lifecycle hook
  // useEffect(() => {
  //   setInterval(() => {
  //     data &&
  //       data.timers.map((timer) => ({
  //         ...timer,
  //         clock: {
  //           elapsed: timer.clock.isRunning
  //             ? timer.clock.elapsed + 1000
  //             : timer.clock.elapsed,
  //         },
  //       }));
  //   });
  // });
  return (
    <View style={styles.appContainer}>
      <View style={styles.titleContainer}>
        <Text style={styles.title}>Timers</Text>
      </View>
      <KeyboardAvoidingView
        behavior="padding"
        style={styles.timerListContainer}
      >
        <ScrollView style={styles.timerList}>
          <ToggleableTimerForm />

          {error ? (
            <Text>Error</Text>
          ) : loading ? (
            <StatusBar barStyle="light-content" />
          ) : (
            data &&
            data.timers.map((timer) => (
              <EditableTimer
                key={timer.id}
                id={timer.id}
                title={timer.title}
                project={timer.project}
                //elapsed={timer.clock.elapsed}
                //isRunning={timer.clock.isRunning}
              />
            ))
          )}
        </ScrollView>
      </KeyboardAvoidingView>
    </View>
  );
};

const styles = StyleSheet.create({
  appContainer: {
    flex: 1,
  },
  titleContainer: {
    paddingTop: 35,
    paddingBottom: 15,
    borderBottomWidth: 1,
    borderBottomColor: "#D6D7DA",
  },
  title: {
    fontSize: 18,
    fontWeight: "bold",
    textAlign: "center",
  },
  timerList: {
    paddingBottom: 15,
  },
  timerListContainer: {
    flex: 1,
  },
});

export default App;
