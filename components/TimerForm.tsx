import { useMutation } from "@apollo/client";
import React, { useState } from "react";
import { StyleSheet, Text, TextInput, View } from "react-native";
import { UPDATE_TIMER } from "../graphql/mutation/timer";
import { TimerButton } from "./TimerButton";

type submitText = "Update" | "Create";

// interface AllProp {
//   id: string;
//   title: string;
//   project: string;
//   onCancel: () => void;
// }

function TimerForm({ id, title, project, onCancel, onEditPress }): JSX.Element {
  //logic for submit button

  // React hooks
  const [timerFormTitle, setTimerFormTitle] = useState(title);
  const [timerFormProject, setTimerFormProject] = useState(project);

  // Apollo hook
  const [updateTimer] = useMutation(UPDATE_TIMER);

  const mutationVars = {
    id: id,
    project: timerFormProject,
    title: timerFormTitle,
  };

  return (
    <View style={styles.formContainer}>
      <View style={styles.attributeContainer}>
        <Text style={styles.textInputTitle}>Title</Text>
        <View style={styles.textInputContainer}>
          <TextInput
            style={styles.textInput}
            underlineColorAndroid="transparent"
            autoFocus={true}
            defaultValue={timerFormTitle}
            onChangeText={(text) => setTimerFormTitle(text)}
          />
        </View>
      </View>
      <View style={styles.attributeContainer}>
        <Text style={styles.textInputTitle}>Project</Text>
        <View style={styles.textInputContainer}>
          <TextInput
            style={styles.textInput}
            underlineColorAndroid={"transparent"}
            defaultValue={timerFormProject}
            onChangeText={(text) => setTimerFormProject(text)}
          />
        </View>
      </View>
      <View style={styles.buttonGroup}>
        <TimerButton
          small
          color="#21BA45"
          title="Submit"
          onPress={() => {
            updateTimer({ variables: mutationVars });
            onEditPress();
          }}
        />
        <TimerButton small color="#DB2828" title="Cancel" onPress={onCancel} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  formContainer: {
    backgroundColor: "white",
    borderColor: "#D6D7DA",
    borderWidth: 2,
    borderRadius: 10,
    padding: 15,
    margin: 15,
    marginBottom: 0,
  },
  attributeContainer: {
    marginVertical: 8,
  },
  textInputContainer: {
    borderColor: "#D6D7DA",
    borderRadius: 2,
    borderWidth: 1,
    marginBottom: 5,
  },
  textInput: {
    height: 30,
    padding: 5,
    fontSize: 12,
  },
  textInputTitle: {
    fontSize: 14,
    fontWeight: "bold",
    marginBottom: 5,
  },
  buttonGroup: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
});

export default TimerForm;
