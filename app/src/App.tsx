import type { ReactNode } from "react";
import { Navigate, Route, Routes } from "react-router-dom";
import { useStore } from "./store";
import { AuthScreen } from "./screens/AuthScreen";
import { HomeScreen } from "./screens/HomeScreen";
import { AreasScreen } from "./screens/AreasScreen";
import { TopicListScreen } from "./screens/TopicListScreen";
import { TopicDetailScreen } from "./screens/TopicDetailScreen";
import { ProgressionScreen } from "./screens/ProgressionScreen";
import { ProfileScreen } from "./screens/ProfileScreen";
import { EducatorHomeScreen } from "./screens/educator/EducatorHomeScreen";
import { EducatorProtagonistsScreen } from "./screens/educator/EducatorProtagonistsScreen";
import { EducatorProtagonistProgressionScreen } from "./screens/educator/EducatorProtagonistProgressionScreen";
import { EducatorTopicsScreen } from "./screens/educator/EducatorTopicsScreen";
import { EducatorTopicDetailScreen } from "./screens/educator/EducatorTopicDetailScreen";

function Guard({ children }: { children: ReactNode }) {
  const { session, ready } = useStore();
  if (!ready) return <div className="auth-wrap">Cargando…</div>;
  if (!session) return <AuthScreen />;
  return children;
}

function EducatorOnly({ children }: { children: ReactNode }) {
  const { session } = useStore();
  if (session?.user.role !== "educador") return <Navigate to="/" replace />;
  return children;
}

function ProtagonistOnly({ children }: { children: ReactNode }) {
  const { session } = useStore();
  if (session?.user.role === "educador") return <Navigate to="/educador" replace />;
  return children;
}

export function App() {
  return (
    <Guard>
      <Routes>
        <Route
          path="/"
          element={
            <ProtagonistOnly>
              <HomeScreen />
            </ProtagonistOnly>
          }
        />
        <Route
          path="/areas"
          element={
            <ProtagonistOnly>
              <AreasScreen />
            </ProtagonistOnly>
          }
        />
        <Route
          path="/areas/:areaId"
          element={
            <ProtagonistOnly>
              <TopicListScreen />
            </ProtagonistOnly>
          }
        />
        <Route
          path="/areas/:areaId/temas/:topicId"
          element={
            <ProtagonistOnly>
              <TopicDetailScreen />
            </ProtagonistOnly>
          }
        />
        <Route
          path="/progresion"
          element={
            <ProtagonistOnly>
              <ProgressionScreen />
            </ProtagonistOnly>
          }
        />
        <Route
          path="/perfil"
          element={
            <ProtagonistOnly>
              <ProfileScreen />
            </ProtagonistOnly>
          }
        />

        <Route
          path="/educador"
          element={
            <EducatorOnly>
              <EducatorHomeScreen />
            </EducatorOnly>
          }
        />
        <Route
          path="/educador/perfil"
          element={
            <EducatorOnly>
              <ProfileScreen />
            </EducatorOnly>
          }
        />
        <Route
          path="/educador/protagonistas"
          element={
            <EducatorOnly>
              <EducatorProtagonistsScreen />
            </EducatorOnly>
          }
        />
        <Route
          path="/educador/protagonistas/:personId"
          element={
            <EducatorOnly>
              <EducatorProtagonistProgressionScreen />
            </EducatorOnly>
          }
        />
        <Route
          path="/educador/fichas"
          element={
            <EducatorOnly>
              <EducatorTopicsScreen />
            </EducatorOnly>
          }
        />
        <Route
          path="/educador/fichas/:topicId"
          element={
            <EducatorOnly>
              <EducatorTopicDetailScreen />
            </EducatorOnly>
          }
        />

        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Guard>
  );
}
