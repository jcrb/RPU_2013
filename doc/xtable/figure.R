\begin{figure}
\begin{center}
<<alsace_recours, echo=FALSE, fig.height=5>>=
  main <- paste0("Titre_principal", anc)
@
\end{center}
\caption{\Sexpr{main}.}
\label{fig:}
\end{figure}

Si on ne veut pas faire flotter

\begin{center}
\includegraphics{foo}
\captionof{figure}{caption text}
\label{fig:nonfloat}
\end{center}