import React, { useState } from "react";
import { KeyboardAvoidingView } from "react-native";
import { Timer } from "./Timer";
import TimerForm from "./TimerForm";

export default function ({ id, title, project }) {
  const [editFormOpen, setEditFormOpen] = useState(false);

  if (editFormOpen) {
    return (
      <KeyboardAvoidingView>
        <TimerForm
          id={id}
          title={title}
          project={project}
          onCancel={() => setEditFormOpen(false)}
          onEditPress={() => setEditFormOpen(false)}
        />
      </KeyboardAvoidingView>
    );
  }

  return (
    <Timer
      id={id}
      title={title}
      project={project}
      //elapsed={elapsed}
      onEditPress={() => setEditFormOpen(true)}
      //isRunning={isRunning}
    />
  );
}
